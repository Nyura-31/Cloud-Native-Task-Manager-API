#!/usr/bin/env sh
# Installs production dependencies and confirms the API can start and serve health checks.
# The temporary server process is always stopped before this script exits.

set -eu

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
PROJECT_DIR=$(dirname "$SCRIPT_DIR")
APP_LOG=""
APP_PID=""

cleanup() {
  if [ -n "$APP_PID" ] && kill -0 "$APP_PID" 2>/dev/null; then
    kill "$APP_PID" 2>/dev/null || true
    wait "$APP_PID" 2>/dev/null || true
  fi

  if [ -n "$APP_LOG" ] && [ -f "$APP_LOG" ]; then
    rm -f "$APP_LOG"
  fi
}

trap cleanup EXIT INT TERM

cd "$PROJECT_DIR"

echo "Installing dependencies..."
npm ci

APP_LOG=$(mktemp)
npm start >"$APP_LOG" 2>&1 &
APP_PID=$!

attempt=1
while [ "$attempt" -le 10 ]; do
  if ! kill -0 "$APP_PID" 2>/dev/null; then
    echo "Application failed to start:" >&2
    cat "$APP_LOG" >&2
    exit 1
  fi

  if curl --fail --silent --show-error http://localhost:3000/health >/dev/null; then
    echo "Build verification successful. Application started successfully."
    exit 0
  fi

  attempt=$((attempt + 1))
  sleep 1
done

echo "Application did not become healthy within 10 seconds:" >&2
cat "$APP_LOG" >&2
exit 1
