SHELL:=/bin/bash

STACKS=sample-application

.PHONY: lint
lint:
	@find . -name "*.yaml" | xargs cfn-lint
