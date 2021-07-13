#!/bin/bash
do_run_python_tests(){
   cd "$PRODUCT_DIR/src/python/min-jinja" || exit 1
   export JUNIT_OUTPUT_DIR="$PRODUCT_DIR/dat/tests_report/python"
   poetry run coverage run --include="./*,src/*" --omit=".venv/**/*.py" \
      -m pytest --junitxml="$JUNIT_OUTPUT_DIR/junit.xml" -s --maxfail=1
   poetry run coverage report --fail-under=80 -m
   poetry run coverage html -d "$JUNIT_OUTPUT_DIR"
   cd "$PRODUCT_DIR" || exit 1
}
