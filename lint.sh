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

for fakeIntegration in yahoofinance; do
    mkdir -p "/config/custom_components/${fakeIntegration}"
    cat <<EOF >"/config/custom_components/${fakeIntegration}/manifest.json"
{
    "domain": "${fakeIntegration}",
    "name": "${fakeIntegration}",
    "codeowners": [],
    "dependencies": [],
    "documentation": "",
    "requirements": [],
    "issue_tracker": "",
    "version": "1.0.0"
}
EOF
done

cp /config/hass-config-lint/secrets.dummy.yaml /config/secrets.yaml

hass --script check_config --config /config --files --fail-on-warnings
