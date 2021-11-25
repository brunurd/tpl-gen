#!/usr/bin/env bash
do_print_usage(){
   # if $run_unit is --help, then message will be "--help deployer PURPOSE"
   cat << EOF_USAGE
   :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
   This is a generic bash functions runner.
   All the functions to run must follow these conventions:
    - residue under src/bash/run
    - their file names must end up with *.func.sh
    - their function names must have the do_ prefix and the snake-cased file name
   :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

   You can also execute one or multiple actions with the
   $0 --action <<action-name>>
   or
   $0 -a <<action-name>> -a <<action-name-02>>

   where the <<action-name>> is one of the following

EOF_USAGE

   find src/bash/run/ -name *.func.sh \
      | perl -ne 's/(.*)(\/)(.*).func.sh/$3/g;print'| perl -ne 's/-/_/g;print "do_" . $_' | sort

   echo -e "\n"

   exit 1
}
