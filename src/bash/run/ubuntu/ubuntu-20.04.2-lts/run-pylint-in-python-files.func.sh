#!/bin/bash
do_run_pylint_in_python_files(){
   cd "$PRODUCT_DIR/src/python/min-jinja" || exit 1
   poetry run pylint ./*
   cd "$PRODUCT_DIR" || exit 1
}
