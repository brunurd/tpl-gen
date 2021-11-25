#!/usr/bin/env bash
do_check_install_poetry(){
   ver=$(poetry --version 2>/dev/null) ; err=$?
   test $err -eq 0 && ver="${ver//Poetry version /}"

   export POETRY_VERSION=1.1.10

   test "$ver" != $POETRY_VERSION && {
      curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -
      sudo ln -s "$HOME/.poetry/bin/poetry" /usr/bin/poetry
      sudo chmod 700 /usr/bin/poetry
      echo "source $HOME/.poetry/env" >> $HOME/.bashrc
   }

   poetry --version

   poetry self update
}
