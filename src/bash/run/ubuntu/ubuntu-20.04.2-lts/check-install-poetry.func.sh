#!/bin/bash
do_check_install_poetry(){

   export POETRY_VERSION=1.1.6
   command -v poetry 1>/dev/null || {
      curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -
      sudo ln -s $HOME/.poetry/bin/poetry /usr/bin/poetry
      sudo chmod 700 /usr/bin/poetry
   }

   poetry --version

}
