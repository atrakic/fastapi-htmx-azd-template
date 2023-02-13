all:
	COMPOSE_DOCKER_CLI_BUILD=1 DOCKER_BUILDKIT=1 docker-compose up --build --remove-orphans --force-recreate -d

pylint:
	pylint $(shell git ls-files '*.py')

release: ## Release (eg. V=0.0.1)
	 @[ "$(V)" ] \
		 && read -p "Press enter to confirm and push tag v$(V) to origin, <Ctrl+C> to abort ..." \
		 && git tag v$(V) -m "v$(V)" \
		 && git push origin v$(V)

clean: ## Clean up
	docker-compose rm -s -a -v -f || true
