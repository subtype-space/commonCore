#!/bin/bash
# Author: Andrew Subowo
# Some common core scripts I use on a day to day basis that I find helpful
# @_subtype / subtype / 2023
# This script sources the _subtype common core bash library

INITDIR=$(pwd)

trap "cd $INITDIR" EXIT

# Get directory where this file is currently
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
cd $SCRIPTPATH

if [ ! -d $SCRIPTPATH/bash ]; then
    echo "Subtype Common Core Bash library not found"
fi

if [ -d $SCRIPTPATH/bash/utils ]; then
    for FILE in $SCRIPTPATH/bash/utils/*; do
        # Source files in the current shell, not a sub-shell
        . "$FILE"
        echo "Sourced $FILE"
    done
else
    echo "Subtype Common Core Bash Utility library not found"
fi