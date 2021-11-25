# file: src/make/install-imgs.incl.mk

.PHONY: install-tpl-gen  ## @-> setup the whole local tpl-gen environment
install-tpl-gen:
	$(call install-img,tpl-gen)


# eof file: src/make/install-imgs.incl.mk
