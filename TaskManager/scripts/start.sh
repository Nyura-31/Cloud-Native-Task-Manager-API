#!/usr/bin/env sh
# Starts the Task Manager API.
# Dependencies are installed only when node_modules is not already present.

set -eu

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
PROJECT_DIR=$(dirname "$SCRIPT_DIR")

cd "$PROJECT_DIR"

if [ ! -d "node_modules" ]; then
  echo "Installing dependencies..."
  npm ci
fi

echo "Starting Task Manager API..."
exec npm start
