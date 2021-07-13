default: help

.PHONY: help ## @-> Show all commands and descriptions.
help:
	@fgrep -h "##" $(MAKEFILE_LIST)|fgrep -v fgrep|sed -e 's/^\.PHONY: //'|sed -e 's/^\(.*\)##/\1/'|column -t -s $$'@'

.PHONY: install ## @-> Setup the whole docker environment to run this project.
install: do_build_devops_docker_image do_create_container

.PHONY: install_no_cache ## @-> Setup the whole environment to run this project, building Dockerimage with no-cache.
install_no_cache: do_build_devops_docker_image_no_cache do_create_container

.PHONY: run ## @-> Run the main function.
run: generate_templates

.PHONY: do_run ## @-> Run the main function in the docker container.
do_run: do_generate_templates

.PHONY: do_build_devops_docker_image ## @-> Build the devops docker image.
do_build_devops_docker_image:
	docker build . -t min-jinja-devops-img --build-arg UID=$(shell id -u) --build-arg GID=$(shell id -g) -f src/docker/devops/Dockerfile

.PHONY: do_build_devops_docker_image_no_cache ## @-> Build the devops docker image with no-cache.
do_build_devops_docker_image_no_cache:
	docker build . -t min-jinja-devops-img --no-cache --build-arg UID=$(shell id -u) --build-arg GID=$(shell id -g) -f src/docker/devops/Dockerfile

.PHONY: do_create_container ## @-> Create a new container using the builded devops image.
do_create_container: stop_container
	docker run -d -v $$(pwd):/opt/min-jinja \
   	-v $$HOME/.ssh:/home/ubuntu/.ssh \
		--name proj-con min-jinja-devops-img ;
	@echo -e to attach run: "\ndocker exec -it proj-con /bin/bash"
	@echo -e to get help run: "\ndocker exec -it proj-con ./run --help"

.PHONY: stop_container ## @-> Stop the devops running container.
stop_container:
	-docker container stop $$(docker ps -aqf "name=proj-con") && docker container rm $$(docker ps -aqf "name=proj-con")

.PHONY: zip_me ## @-> Zip the whole project without the .git directory.
zip_me:
	-rm -v ../min-jinja.zip
	git archive --format zip -o ../min-jinja.zip HEAD

demand_var-%:
	@if [ "${${*}}" = "" ]; then \
		echo "the var \"$*\" is not set, do set it by: export $*='value'"; \
		exit 1; \
	fi

task-which-requires-a-var: demand_var-ENV_TYPE ## @-> a helper task to test a required var
	@echo ${ENV_TYPE}

.PHONY: spawn_tgt_project ## @-> Spawn a complete new project from this one.
spawn_tgt_project: demand_var-TGT_PROJ zip_me
	-rm -r $(shell echo $(dir $(abspath $(dir $$PWD)))$$TGT_PROJ)
	unzip -o ../min-jinja.zip -d $(shell echo $(dir $(abspath $(dir $$PWD)))$$TGT_PROJ)
	to_srch=min-jinja to_repl=$(shell echo $$TGT_PROJ) dir_to_morph=$(shell echo $(dir $(abspath $(dir $$PWD)))$$TGT_PROJ) ./run -a do_morph_dir

.PHONY: do_prune_docker_system ## @-> Stop, remove and clean all containers and non used resources in the docker.
do_prune_docker_system:
	-docker kill $$(docker ps -q) ; -docker rm $(docker ps -a -q)
	docker builder prune -f --all ; docker system prune -f


.PHONY: generate_templates ## @-> Generate the templates for all the *.tpl files in the project.
generate_templates: demand_var-ENV_TYPE
	ENV_TYPE=$$ENV_TYPE ./run -a do_generate_templates

.PHONY: do_generate_templates ## @-> Generate the templates for all the *.tpl files in the project in the docker devops container.
do_generate_templates: demand_var-ENV_TYPE
	docker exec -e ENV_TYPE=$$ENV_TYPE -it proj-con ./run -a do_generate_templates
