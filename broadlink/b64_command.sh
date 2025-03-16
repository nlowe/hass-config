#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"

if (( $# != 1 )); then
    echo >&2 "Syntax: $0 <code file>"
    exit 1
fi

COMMAND_FILE="codes/${1}"
if [[ ! -f "${COMMAND_FILE}" ]]; then
    echo >&2 "Unknown Command: ${1}"
    exit 1
fi

echo "b64:$(xxd -r -p "${COMMAND_FILE}" | base64 -w 0)" | tee "${COMMAND_FILE}.b64"
