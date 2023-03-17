SHELL:=/bin/bash
CLOUDFOMULA=./cloudfomula

STACKS=sample-application

.PHONY: lint
lint:
	@find . -name "*.yaml" | xargs cfn-lint

.PHONY: check_params
check_params:
	@if [ -z "${STACK}" ]; then \
		echo "Usage: STACK={stack_name} CID={changeset_suffix?} make plan"; \
		exit 1; \
	elif [ ! -d "${STACK}" ]; then \
		echo "Error: directory '${STACK}' does not exist"; \
		exit 1; \
	fi

.PHONY: plan
plan: check_params
	@for file in "${STACK}/*.properties"; do \
        env=$$(basename $${file} | cut -d'.' -f 1); \
		${CLOUDFOMULA} plan ${STACK} $${env} ${CID}; \
	done

.PHONY: apply
apply: check_params
	@for file in "${STACK}/*.properties"; do \
        env=$$(basename $${file} | cut -d'.' -f 1); \
		${CLOUDFOMULA} apply ${STACK} $${env} ${CID}; \
	done

.PHONY: abort
abort: check_params
	@for file in "${STACK}/*.properties"; do \
        env=$$(basename $${file} | cut -d'.' -f 1); \
		${CLOUDFOMULA} abort ${STACK} $${env} ${CID}; \
	done

.PHONY: comment
comment: check_params
	@for file in "${STACK}/*.properties"; do \
        env=$$(basename $${file} | cut -d'.' -f 1); \
		${CLOUDFOMULA} comment ${STACK} $${env} ${CID}; \
	done

.PHONY: echo
echo: check_params
	@for file in "${STACK}/*.properties"; do \
		echo $${file} >&2; \
		cat $${file}; \
		echo ""; \
	done