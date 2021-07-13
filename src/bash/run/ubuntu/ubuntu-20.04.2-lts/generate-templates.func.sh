#!/bin/bash
do_generate_templates(){
   do_read_conf_section ".env.aws"
   cd "$PRODUCT_DIR/src/python/min-jinja" || exit 1
   test -d .venv || do_check_install_python_modules
   poetry run python tpl_gen.py
}
