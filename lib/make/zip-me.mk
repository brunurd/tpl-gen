.PHONY: zip_me ## @-> zip the whole project without the .git dir
zip_me:
	@clear
	-rm -v ../$(PRODUCT).zip ; zip -r ../$(PRODUCT).zip  . -x '*.git*'
	@sleep 1
	@clear
	@echo done check
	@echo $(PWD)/../$(PRODUCT).zip