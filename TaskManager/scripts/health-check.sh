#!/usr/bin/env sh
# Checks whether the locally running Task Manager API responds at /health.

set -eu

if curl --fail --silent --show-error http://localhost:3000/health >/dev/null; then
  echo "Application is healthy"
else
  echo "Application is not running"
  exit 1
fi
