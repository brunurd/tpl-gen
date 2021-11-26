#!/bin/bash
do_generate_templates(){
   do_read_conf_section '.env.aws'
   source $HOME/.poetry/env
   cd "$PRODUCT_DIR/src/python/tpl-gen"
   poetry run python "tpl_gen/tpl_gen.py"
}
