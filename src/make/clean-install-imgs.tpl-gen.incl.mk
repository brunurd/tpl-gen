# file: src/make/clean-install-imgs.incl.mk


.PHONY: clean-install-tpl-gen  ## @-> setup the whole local tpl-gen environment for python
clean-install-tpl-gen:
	$(call clean-install-img,tpl-gen)



# eof file: src/make/clean-install-imgs.incl.mk
