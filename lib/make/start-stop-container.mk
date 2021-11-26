.PHONY: do-start-$(component)-container ## @-> start a new container from the built $(component) image
do-start-$(component)-container: demand_var-ENV do-stop-$(component)-container
	@clear
	docker run -d --restart=always \
		-v $$(pwd):/opt/${PRODUCT} \
		-v $$HOME/.aws:/home/appusr/.aws \
		-v $$HOME/.ssh:/home/appgrp/.ssh \
		-p $(exposed_port):$(exposed_port) \
		--name ${PRODUCT}-$(component)-con ${PRODUCT}-${component}-img ;
	@echo -e to attach run: "\ndocker exec -it ${PRODUCT}-${component}-con /bin/bash"
	@echo -e to get help run: "\ndocker exec -it ${PRODUCT}-${component}-con ./run --help"

.PHONY: do-stop-$(component)-container ## @-> stop the $(component) running container
do-stop-$(component)-container:
	@clear
	-@docker container stop $$(docker ps -aqf "name=${PRODUCT}-${component}-con") 2> /dev/null
	-@docker container rm $$(docker ps -aqf "name=${PRODUCT}-${component}-con") 2> /dev/null
