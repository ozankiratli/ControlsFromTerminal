#!/bin/bash

echo "This script installs required scripts without extensions to /usr/local/bin" 

FOLDER=`echo ${0} | sed 's|/| |g' | awk '{$NF=""; print $0}' | sed 's| |/|g'`

FULLPATH=$PWD'/'$FOLDER

SCRIPTS=`ls --ignore=*.* $FULLPATH`

for script in $SCRIPTS; do
  SN=$FULLPATH$script
  sudo ln -s $SN /usr/local/bin/$script
done


