#!/usr/bin/env bash

if [[ ! -d /config/hass-config-lint ]]; then
    echo >&2 "This script should be run via: make lint"
    exit 1
fi

cat <<'EOF' >/config/configuration.yaml
!include hass-config-lint/main.yaml
EOF

for fake in automations.yaml scenes.yaml scripts.yaml; do
    touch "/config/${fake}"
done

cp /config/hass-config-lint/secrets.dummy.yaml /config/secrets.yaml

hass --script check_config --config /config --files --fail-on-warnings
