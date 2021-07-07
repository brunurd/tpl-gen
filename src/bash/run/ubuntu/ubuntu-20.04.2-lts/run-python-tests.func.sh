do_run_python_tests(){
    # Workaround to use the pytest.ini in the tests.
    sudo cp $PRODUCT_DIR/cnf/bin/python/pytest.ini `pwd`/pytest.ini
    python3 -m pytest
    sudo rm `pwd`/pytest.ini
}
