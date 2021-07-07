do_run_pylint_in_python_files(){
    python3 -m pylint $PRODUCT_DIR/src/python --rcfile=$PRODUCT_DIR/cnf/bin/python/.pylintrc
}
