#!/usr/bin/env bash
do_run_pylint_in_tpl_gen(){
    cd "$PRODUCT_DIR/src/python/tpl-gen"
    poetry run pylint ./**
    cd -
}
