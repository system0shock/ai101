#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
APP="$ROOT/app"
BUILD="$ROOT/build"
MAIN_CLASSES="$BUILD/classes-main"
TEST_CLASSES="$BUILD/classes-test"
JAR="$ROOT/lib/junit-platform-console-standalone-1.10.2.jar"

if [[ ! -f "$JAR" ]]; then
  echo "Не найден JUnit jar: $JAR" >&2
  exit 1
fi

rm -rf "$BUILD"
mkdir -p "$MAIN_CLASSES" "$TEST_CLASSES"

mapfile -t MAIN_SOURCES < <(find "$APP/src/main/java" -name "*.java" -print)
mapfile -t TEST_SOURCES < <(find "$APP/src/test/java" -name "*.java" -print)

javac -encoding UTF-8 -d "$MAIN_CLASSES" "${MAIN_SOURCES[@]}"
javac -encoding UTF-8 -cp "$JAR:$MAIN_CLASSES" -d "$TEST_CLASSES" "${TEST_SOURCES[@]}"
java -jar "$JAR" execute --class-path "$MAIN_CLASSES:$TEST_CLASSES" --scan-class-path
