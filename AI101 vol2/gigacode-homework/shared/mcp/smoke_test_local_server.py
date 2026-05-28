#!/usr/bin/env python3
import json
import subprocess
import sys
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]
SERVER = ROOT / "shared" / "mcp" / "local_knowledge_server.py"


def send(process, message):
    process.stdin.write(json.dumps(message) + "\n")
    process.stdin.flush()
    return json.loads(process.stdout.readline())


def main():
    process = subprocess.Popen(
        [sys.executable, str(SERVER)],
        cwd=str(ROOT),
        stdin=subprocess.PIPE,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        text=True,
        encoding="utf-8",
    )
    try:
        init = send(process, {
            "jsonrpc": "2.0",
            "id": 1,
            "method": "initialize",
            "params": {"protocolVersion": "2024-11-05", "capabilities": {}, "clientInfo": {"name": "smoke", "version": "1"}},
        })
        assert init["result"]["serverInfo"]["name"] == "ai101-local-knowledge"

        tools = send(process, {"jsonrpc": "2.0", "id": 2, "method": "tools/list", "params": {}})
        names = {tool["name"] for tool in tools["result"]["tools"]}
        assert "get_discount_policy" in names
        assert "search_credit_policy" in names

        call = send(process, {
            "jsonrpc": "2.0",
            "id": 3,
            "method": "tools/call",
            "params": {"name": "get_discount_policy", "arguments": {"policy": "bulk-discount"}},
        })
        text = call["result"]["content"][0]["text"]
        assert "10% discount starts from 10 items inclusive" in text
    finally:
        process.terminate()
        process.wait(timeout=5)

    print("Local MCP stdio smoke test passed.")


if __name__ == "__main__":
    main()
