.PHONY: lint

lint:
	find . -name "*.yaml" | xargs cfn-lint
