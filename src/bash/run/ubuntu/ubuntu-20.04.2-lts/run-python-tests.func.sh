#!/bin/bash
do_run_python_tests(){
   cd "$PRODUCT_DIR/src/python/min-jinja" || exit 1
   poetry run pytest
   cd "$PRODUCT_DIR" || exit 1
}
