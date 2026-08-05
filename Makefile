HASS_VERSION := 2026.7.2

.PHONY: all
all: lint editorconfig-checker

.PHONY: lint
lint:
	@docker run \
		-i --rm \
		-v $(shell pwd):/config/hass-config-lint \
		ghcr.io/home-assistant/home-assistant:$(HASS_VERSION) \
			/config/hass-config-lint/lint.sh

.PHONY: editorconfig-checker
editorconfig-checker:
	@editorconfig-checker
