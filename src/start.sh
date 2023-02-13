#!/bin/bash

set -o errexit
set -o pipefail
set -o nounset

PORT=${PORT:-3000}
HOST=${HOST:-0.0.0.0}

cat << EOF
$(basename "$0") $PORT $HOST
EOF

uvicorn main:app --port "$PORT" --host "$HOST"
