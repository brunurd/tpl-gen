#!/bin/bash
do_run_pylint_in_python_files(){
   cd "$PRODUCT_DIR/src/python/tpl-gen"
   poetry run pylint ./* --rcfile=.pylintrc
   cd $PRODUCT_DIR
}
