#!/bin/bash
set -eo pipefail

curl -o /dev/null -sf -X 'GET' \
  'http://localhost:3000/ping' \
  -H 'accept: application/json'
