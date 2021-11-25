# usage example
# some-target: demand_var-ENV another-target
demand_var-%:
	@if [ "${${*}}" = "" ]; then \
		echo "the var \"$*\" is not set, do set it by: export $*='value'"; \
		exit 1; \
	fi

# function usage example
# install-web-node-img:
# 	$(call demand-var,ENV)
# 	do-build-$(component)-docker-img
define demand-var
	@if [ "${${1}}" = "" ]; then \
		echo "the var \"$1\" is not set, do set it by: export $1='value'"; \
		exit 1; \
	fi
endef
