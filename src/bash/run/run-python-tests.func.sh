#!/bin/bash
do_run_python_tests(){
   cd "$PRODUCT_DIR/src/python/tpl-gen"
   poetry run pytest
   cd $PRODUCT_DIR
}
