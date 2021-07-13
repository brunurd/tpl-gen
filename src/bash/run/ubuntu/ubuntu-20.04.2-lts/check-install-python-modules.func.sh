#!/bin/bash
do_check_install_python_modules(){
   do_check_install_poetry
   cd "$PRODUCT_DIR/src/python/min-jinja" || exit 1
   poetry install
}
