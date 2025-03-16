#!/bin/bash
# Author: Andrew Subowo
# Some common core scripts I use on a day to day basis that I find helpful
# @_subtype / subtype / 2023
# To use the functions in this script, merely source it (e.g. source <script aname>)
# This script allows one to quickly compare the md5sum of two files together

INITDIR=$(pwd)

trap "cd $INITDIR" EXIT

# Get directory where this file is currently
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
cd $SCRIPTPATH
source ../../utils/comphash.sh
source ../../utils/logging.sh

# Test
echo "Testing file comparison, shell, empty"
if comphash ./test1.txt ./test2.txt; then
    ok
else
    fail
fi

echo "Testing file comparison, shell, differing"
if ! comphash ./test1.txt ./test3.txt; then
    ok
else
    fail
fi

echo "Testing two files with different extensions"
if comphash ./test1.txt ./test4.sh; then
    ok
else
    fail
fi