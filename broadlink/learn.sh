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

LEARNFILE="codes/${1}"

echo "Learning ${LEARNFILE} via ${DEVICE_NAME}"
mkdir -p "$(dirname "${LEARNFILE}")"

broadlink_cli --device "@${DEVICE_FILE}" --learnfile "${LEARNFILE}"
./b64_command.sh "${LEARNFILE}"
