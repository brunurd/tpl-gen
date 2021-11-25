# file: src/make/local-setup-tasks.incl.mk


.PHONY: tpl-gen ## @-> apply the environment cnf file into the templates
tpl-gen: demand_var-ENV
	@cd $(PRODUCT_DIR)/src/python/tpl-gen && poetry run python tpl_gen/tpl_gen.py


.PHONY: pylint ## @-> check linting with pylint
pylint:
	@cd $(PRODUCT_DIR)/src/python/tpl-gen
	./run -a do_run_pylint_in_python_files


# eof file: src/make/local-setup-tasks.incl.mk
