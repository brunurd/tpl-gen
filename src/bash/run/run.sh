#!/usr/bin/env bash
   

unit_run_dir=$(perl -e 'use File::Basename; use Cwd "abs_path"; print dirname(abs_path(@ARGV[0]));' -- "$0")
export PRODUCT_DIR=$(cd $unit_run_dir/../../.. ; echo `pwd`)

if [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
	bash $PRODUCT_DIR/src/bash/run/ubuntu/run.sh "$@"
elif [ "$(expr substr $(uname -s) 1 5)" != "Linux" ]; then
   echo "your OS is not supported !!!"
fi

# must be always relative !!!
cd $PRODUCT_DIR ; ln -sfn ./src/bash/run/run.sh ./run
