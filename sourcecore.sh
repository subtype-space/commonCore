#!/bin/bash
# Author: Andrew Subowo
# Some common core scripts I use on a day to day basis that I find helpful
# @_subtype / subtype / 2023
# This script sources the _subtype common core bash library

INITDIR=$(pwd)
trap "cd $INITDIR" EXIT
VERBOSE=false
# Get directory where this file is currently
SCRIPTPATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd $SCRIPTPATH

function checkUpdate() {

  UPSTREAM=${1:-'@{u}'}
  LOCAL=$(git rev-parse @)
  REMOTE=$(git rev-parse "$UPSTREAM")
  BASE=$(git merge-base @ "$UPSTREAM")
  if [ $LOCAL = $REMOTE ]; then
    : # Do nothing no-op
  elif [ $LOCAL = $BASE ]; then
    echo "An update is available! Please update the repository via git fetch, then git pull."
  fi
}

# main function
function main() {
  #checkUpdate
  if [ ! -d $SCRIPTPATH/bash ]; then
      echo "_subtype Common Core bash library not found or malformed."
  fi

  if [ -d $SCRIPTPATH/bash/utils ]; then
      for FILE in $SCRIPTPATH/bash/utils/*; do
          # Source files in the current shell, not a sub-shell
          . "$FILE"
          if $VERBOSE; then
            echo "Sourced $FILE"
          fi
      done
  else
      echo "Bash utils directory not found for sourcing."
  fi
}

while getopts "v" OPTS; do
  case $OPTS in
    v)
      VERBOSE=true
      ;;
    *)
      echo "Unsupported option"
      exit 0
      ;;
  esac
done

checkUpdate
main