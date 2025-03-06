HASS_VERSION := 2025.1.4

.PHONY: all
all: lint

automations.yaml:
	@touch automations.yaml

secrets.yaml: secrets.dummy.yaml
	@cp secrets.dummy.yaml secrets.yaml

.PHONY: fake-files-for-lint
fake-files-for-lint: automations.yaml secrets.yaml

.PHONY: lint
lint: fake-files-for-lint
	@docker run \
		-i --rm \
		-v $(shell pwd):/config:ro \
		ghcr.io/home-assistant/home-assistant:$(HASS_VERSION) \
			hass --script check_config --config /config

.PHONY: editorconfig-checker
editorconfig-checker:
	@editorconfig-checker
