#!/bin/bash
do_run_python_tests(){
   cd "$PRODUCT_DIR/src/python/min-jinja"
   poetry run pytest
   cd $PRODUCT_DIR
}
