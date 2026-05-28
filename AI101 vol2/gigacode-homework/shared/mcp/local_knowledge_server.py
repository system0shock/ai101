#!/usr/bin/env python3
import json
import sys


SERVER_INFO = {
    "name": "ai101-local-knowledge",
    "version": "1.0.0",
}


TOOLS = [
    {
        "name": "get_discount_policy",
        "description": "Return the current read-only bulk discount policy for the developer homework.",
        "inputSchema": {
            "type": "object",
            "properties": {
                "policy": {
                    "type": "string",
                    "description": "Policy key. Use 'bulk-discount'.",
                    "default": "bulk-discount",
                }
            },
            "additionalProperties": False,
        },
    },
    {
        "name": "search_credit_policy",
        "description": "Return a read-only quote from the credit launch policy for the analyst homework.",
        "inputSchema": {
            "type": "object",
            "properties": {
                "query": {
                    "type": "string",
                    "description": "Question about the online credit policy.",
                },
                "clientSegment": {
                    "type": "string",
                    "description": "Optional client segment, for example 'salary'.",
                },
            },
            "additionalProperties": False,
        },
    },
]


def write_message(message):
    sys.stdout.write(json.dumps(message, ensure_ascii=False, separators=(",", ":")) + "\n")
    sys.stdout.flush()


def text_result(text):
    return {"content": [{"type": "text", "text": text}]}


def handle_request(message):
    request_id = message.get("id")
    method = message.get("method")
    params = message.get("params") or {}

    if method == "initialize":
        requested_version = params.get("protocolVersion") or "2024-11-05"
        return {
            "jsonrpc": "2.0",
            "id": request_id,
            "result": {
                "protocolVersion": requested_version,
                "capabilities": {"tools": {"listChanged": False}},
                "serverInfo": SERVER_INFO,
            },
        }

    if method == "ping":
        return {"jsonrpc": "2.0", "id": request_id, "result": {}}

    if method == "tools/list":
        return {"jsonrpc": "2.0", "id": request_id, "result": {"tools": TOOLS}}

    if method == "tools/call":
        tool_name = params.get("name")
        arguments = params.get("arguments") or {}
        if tool_name == "get_discount_policy":
            policy = arguments.get("policy", "bulk-discount")
            if policy != "bulk-discount":
                return {
                    "jsonrpc": "2.0",
                    "id": request_id,
                    "error": {"code": -32602, "message": f"Unknown policy: {policy}"},
                }
            return {
                "jsonrpc": "2.0",
                "id": request_id,
                "result": text_result(
                    "Bulk discount policy: 10% discount starts from 10 items inclusive. "
                    "Source: AI101 local policy fixture. Updated: 2026-05-28."
                ),
            }
        if tool_name == "search_credit_policy":
            return {
                "jsonrpc": "2.0",
                "id": request_id,
                "result": text_result(
                    "Credit policy quote: online credit applications are available only "
                    "for salary-account clients with at least 6 months history. "
                    "Maximum amount is 500,000 RUB. Review time is up to 3 business days. "
                    "Source: AI101 local credit policy fixture. Updated: 2026-05-28."
                ),
            }
        return {
            "jsonrpc": "2.0",
            "id": request_id,
            "error": {"code": -32601, "message": f"Unknown tool: {tool_name}"},
        }

    if method == "resources/list":
        return {"jsonrpc": "2.0", "id": request_id, "result": {"resources": []}}

    if method == "prompts/list":
        return {"jsonrpc": "2.0", "id": request_id, "result": {"prompts": []}}

    return {
        "jsonrpc": "2.0",
        "id": request_id,
        "error": {"code": -32601, "message": f"Unknown method: {method}"},
    }


def main():
    for line in sys.stdin:
        line = line.strip()
        if not line:
            continue
        try:
            message = json.loads(line)
        except json.JSONDecodeError as exc:
            write_message({
                "jsonrpc": "2.0",
                "id": None,
                "error": {"code": -32700, "message": f"Invalid JSON: {exc}"},
            })
            continue

        if "id" not in message:
            continue

        write_message(handle_request(message))


if __name__ == "__main__":
    main()
