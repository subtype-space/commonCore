#!/bin/bash
# Author: Andrew Subowo
# Some common core scripts I use on a day to day basis that I find helpful
# @_subtype / subtype / 2023
# To use the functions in this script, merely source it (e.g. source <script aname>)
# This script allows one to quickly compare the md5sum of two files together

function comphash() {
  if ! command -v md5sum &> /dev/null; then
    error "md5sum not installed."
    set +o pipefail
    return 1
  fi

  if [ $# -lt 2 ] || [ $# -gt 2 ]; then
    error "Must pass in two arguments."
  else
    [[ "$(md5sum ${1} ${2} | awk '{print $1}' | uniq | wc -l)" == 1 ]] && return 0 || return 1
  fi
}