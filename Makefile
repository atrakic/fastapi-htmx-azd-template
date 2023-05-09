MAKEFLAGS += --silent
.DEFAULT_GOAL := help

compose: ## Run with docker compose
	COMPOSE_DOCKER_CLI_BUILD=1 DOCKER_BUILDKIT=1 docker-compose up --build --remove-orphans --force-recreate -d

pylint: ## Run pylint
	pylint $(shell git ls-files '*.py')

CHART ?= $(shell basename $$PWD)
release: ## Release (eg. V=0.0.1)
	 @[ "$(V)" ] \
		 && read -p "Press enter to confirm and push tag $(V) to origin, <Ctrl+C> to abort ..." \
		 && git tag $(V) -m "release: $(V)" \
		 && git push origin $(V) -f \
		 && git fetch --tags --force --all -p \
		 && if [ ! -z "$(GITHUB_TOKEN)" ] ; then \
			curl \
			  -H "Authorization: token $(GITHUB_TOKEN)" \
				-X POST	\
				-H "Accept: application/vnd.github.v3+json"	\
				https://api.github.com/repos/atrakic/$(shell basename $$PWD)/releases \
				-d "{\"tag_name\":\"$(V)\",\"generate_release_notes\":true}"; \
			fi;

help:
	awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

clean: ## Clean up
	docker-compose rm -s -a -v -f || true

.PHONY: compose pylint clean help release

-include include.mk
