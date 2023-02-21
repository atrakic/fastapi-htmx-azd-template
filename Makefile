MAKEFLAGS += --silent
.DEFAULT_GOAL := help

compose: ## Run with docker compose
	COMPOSE_DOCKER_CLI_BUILD=1 DOCKER_BUILDKIT=1 docker-compose up --build --remove-orphans --force-recreate -d

pylint: ## Run pylint
	pylint $(shell git ls-files '*.py')

CHART ?= $(shell basename $$PWD)
release: ## Release (eg. V=0.0.1)
	 @[ "$(V)" ] \
		 && read -p "Press enter to confirm and push tag v$(V) to origin, <Ctrl+C> to abort ..." \
		 && git tag v$(V) -m "chore: v$(V)" \
		 && git push origin v$(V) -f \
		 && git fetch --tags --force --all -p \
		 && git describe --tags $(shell git rev-list --tags --max-count=1)

help:
	awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

clean: ## Clean up
	docker-compose rm -s -a -v -f || true

.PHONY: compose pylint clean help release

-include include.mk
