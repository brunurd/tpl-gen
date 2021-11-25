# file: src/make/docker-setup-tasks.incl.mk


.PHONY: do-pylint ## @-> run flake8 via the docker container
do-pylint:
	docker exec -t tpl-gen-tpl-gen-con ./run -a do_run_pylint_in_python_files

.PHONY: do-tpl-gen ## @-> apply the environment cnf file into the templates on the tpl-gen container
do-tpl-gen: demand_var-ENV
	 docker exec -e ENV=$(ENV) -t ${PRODUCT}-${PRODUCT}-con make tpl-gen

# eof file: src/make/docker-setup-tasks.incl.mk
