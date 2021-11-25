#!/bin/bash

# install the poetry for every python component project on the first level
# of the src/python dir
do_check_install_py_modules(){


   which poetry > /dev/null 2>&1 || {
      do_check_install_poetry
   }

   while read -r f; do
      tgt_dir=$(dirname $f)
      echo working on tgt_dirk: $tgt_dir
      cd "$tgt_dir" || exit 1 && do_log "FATAL do_check_install_py_modules ::: the tgt_dir: $tgt_dir does not exist"
      test -f poetry.lock && rm -vf poetry.lock
      test -d .venv && rm -rv .venv
      poetry config virtualenvs.create true
      poetry install -v
      cd -
   done < <(find $PRODUCT_DIR/src/python/ -name pyproject.toml)


}
