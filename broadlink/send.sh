#!/usr/bin/env bash
set -euo pipefail

command -v broadlink_cli >/dev/null 2>&1 || {
    echo >&2 "Need broadlink_cli"
    exit 1
}

cd "$(dirname "$0")"

DEVICE_NAME=${DEVICE_NAME:-living_room}
DEVICE_FILE="devices/${DEVICE_NAME}.device"
if [[ ! -f "${DEVICE_FILE}" ]]; then
    echo >&2 "Unknown device ${DEVICE_NAME}"
    exit 1
fi

if (( $# != 1 )); then
    echo >&2 "Syntax: $0 <code file>"
    exit 1
fi

COMMAND_FILE="codes/${1}"
if [[ ! -f "${COMMAND_FILE}" ]]; then
    echo >&2 "Unknown Command: ${1}"
    exit 1
fi

echo "Sending ${COMMAND_FILE} via ${DEVICE_NAME}"
broadlink_cli --device "@${DEVICE_FILE}" --send $(cat "${COMMAND_FILE}")
