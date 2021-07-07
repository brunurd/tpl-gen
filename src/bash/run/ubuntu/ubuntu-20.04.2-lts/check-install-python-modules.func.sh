#!/bin/bash
do_check_install_python_modules(){

   command -v poetry 1>/dev/null || {
      do_check_install_poetry
      export POETRY_VERSION=1.1.6
      poetry --version
   }

   command -v poetry 1>/dev/null && {
      cd $PRODUCT_DIR/src/python/min-jinja
      export PATH="$HOME/.poetry/bin:${PATH}"
      poetry config virtualenvs.create true
      poetry install
   }
}
