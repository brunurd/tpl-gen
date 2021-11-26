# file: Makefile
# usage: run the "make" command in the root, than make <<cmd>>...
#
# get all the generic fully re-usable make functions
include $(wildcard lib/make/*.mk)
#
# get all the project logic specific tasks
include $(wildcard src/make/*.mk)

PRODUCT := $(shell basename $$PWD)
product := $(shell echo `basename $$PWD`|tr '[:upper:]' '[:lower:]')


.PHONY: install  ## @-> setup the whole local tpl-gen environment (alias)
install: install-tpl-gen


.PHONY: clean-install  ## @-> setup the whole local tpl-gen environment (alias), no docker cache !
clean-install: clean-install-tpl-gen


.PHONY: run ## @-> run some function , in this case hello world
run:
	./run -a do_run_hello_world


.PHONY: do_run ## @-> run some function , in this case hello world
do_run:
	docker exec -it proj-con ./run -a do_run_hello_world


.PHONY: spawn_tgt_project ## @-> spawn a new target project
spawn_tgt_project: demand_var-TGT_PROJ zip_me
	-rm -r $(shell echo $(dir $(abspath $(dir $$PWD)))$$TGT_PROJ)
	unzip -o ..$(product).zip -d $(shell echo $(dir $(abspath $(dir $$PWD)))$$TGT_PROJ)
	to_srch=$(product) to_repl=$(shell echo $$TGT_PROJ) dir_to_morph=$(shell echo $(dir $(abspath $(dir $$PWD)))$$TGT_PROJ) ./run -a do_morph_dir
