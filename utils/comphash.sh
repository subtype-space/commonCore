#!/bin/bash
# Author: Andrew Subowo
# Some common core scripts I use on a day to day basis that I find helpful
# @_subtype / subtype / 2023
# To use the functions in this script, merely source it (e.g. source <script aname>)
# This script allows one to quickly compare the md5sum of two files together

function comphash() {
    if ! command -v md5sum &> /dev/null; then
        echo "md5sum not installed."
        exit 1
    fi

    if [ $# -lt 2 ]; then
        echo "Must pass in at least two arguments."
        exit 1
    else
        # Run bash
        [[ "$(md5sum ${1} | awk '{print $1}')" = "$(md5sum ${2} | awk '{print $1}')" ]] && return 0 || return 1
    fi
}