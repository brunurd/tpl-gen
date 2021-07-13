#!/bin/bash
do_run_pylint_in_python_files(){
   cd "$PRODUCT_DIR/src/python/min-jinja" || exit 1
   log_file="$PRODUCT_DIR/dat/logs/python/pylint.$(date "+%Y%m%d%H%M%S").log"
   poetry run pylint src/* | tee "$log_file" ; exit "${PIPESTATUS[0]}"
   cd "$PRODUCT_DIR" || exit 1
}
