#!/bin/bash
# Author: Andrew Subowo
# Some common core scripts I use on a day to day basis that I find helpful
# @_subtype / subtype / 2023
# This script sources the _subtype common core bash library

# If this script is interrupted, just return the user to the pwd they were in
INITDIR=$(pwd)
trap "cleanup; cd $INITDIR" EXIT

# "Verbose" mode
VERBOSE=false

# Get directory where this file is currently
SCRIPTPATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd $SCRIPTPATH

function CCQUIT() {
  if [ $# -eq 0 ]; then
    RC=1 #Default fail state
  else
    RC=$1
  fi

  if [[ "${BASH_SOURCE[0]}" != "${0}" ]]; then
    # Sourced
    return $RC
  else
    # Not sourced, possibly running in sub-shell
    exit $RC
  fi
}

function CHECK_COMMANDS() {
    for COMMAND in "$@"; do
        if ! command -v $COMMAND > /dev/null; then
            echo "$COMMAND: command not found. Was the _subtype common library properly sourced?"
            exit 1
        fi
    done
}

# Check for updates, don't do any auto update, let the user perform it.
function checkUpdate() {
  if $VERBOSE; then
    echo "Checking for updates..."
  fi
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

function cleanup() {
  unset VERBOSE
  unset SCRIPTPATH
  unset UPSTREAM
  unset LOCAL
  unset REMOTE
  unset BASE
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