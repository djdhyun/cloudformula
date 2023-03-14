SHELL:=/bin/bash

STACKS=sample-application

.PHONY: lint
lint:
	@find . -name "*.yaml" | xargs cfn-lint

.PHONY: deploy-all
deploy-all:
	@source source.me && deploy_stacks $(STACKS)
