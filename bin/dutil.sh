#!/bin/bash
# Author: Andrew Subowo
# docker compose based utils -- these can be translated into aliases
# @_subtype / subtype / 2024

# TODO: Figure out how to determine if this was called via source or not or blah blah blah
# # If this script is interrupted, just return the user to the pwd they were in
# INITDIR=$(pwd)
# trap "cd $INITDIR" EXIT


function usage() {
  echo "usage: dutil [reload|rebuild|networks|ps|psg] [container name]"
  echo -e "  net|network|networks\n\t\t Returns the list of docker networks"
  echo -e "  ps|psg\n\t\t If given a container name, perform a search for it. psg performs a grep instead against docker ps -a"
  echo -e "  rebuild\n\t\t Performs a docker compose down, build, and up, detatched"
  echo -e "  reload\n\t\t Performs a docker compose down and up, detatched"
  echo -e "  shell\n\t\t Runs docker exec -it against a given container name and opens a bash shell (as fallback, use /bin/sh)."
  echo "Part of the _subtype common library"
  exit 1
}

# TODO: EVENTUALLY MAKE THIS COMPLETELY STANDALONE(?) Should be able to detect if core is installed or not
# Check and source some methods that are included as part of the common core
function checkAndSourceCommonCore() {

  # Might get rid of this. Let the user have control.
  # if [ ! -h $0 ]; then
  #   echo "dutil doesn't seem to be referenced as a symbolic link. Please link $0 to dutil in the library or use the provided installer."
  #   exit 1
  # fi

  # If the installer was used, the common library should be symlinked/available
  COMMON_CORE_INSTALL="$( cd $(dirname $(dirname "$(readlink -f "$0")"))  && pwd)"
  if [ ! -d $COMMON_CORE_INSTALL ]; then
    echo "Could not locate the common core library at $COMMON_CORE_INSTALL. Please consider re-pulling the repository"
    exit 1
  else
    source $COMMON_CORE_INSTALL/utils/logging.sh
    source $COMMON_CORE_INSTALL/utils/corefunc.sh
    source $COMMON_CORE_INSTALL/utils/dockerinit.sh
  fi
}

# Main utility function
function dutil() {
  # Get current pwd
  checkAndSourceCommonCore
  CHECK_COMMANDS dockerinit warn ok error
  
  if [ -z $1 ]; then
    usage
  fi

  # TODO: Add v1 support, maybe.
  if ! docker compose version &> /dev/null; then
    echo "Docker compose v2 is not installed"
    return 1
  fi

  case $1 in
    init)
      if ! command -v dockerinit; then
        echo "dockerinit is not present"
        return 1
      else
        dockerinit
      fi
      ;;
    net|network|networks)
      docker network ls
      ;;
    ps)
      if [ -z $2 ]; then
        docker ps -a
      else
        docker ps -a -f name=$2
      fi
      ;;
    psg)
      if [ -z $2 ]; then
        docker ps -a
      else
        docker ps -a | grep $2
      fi
      ;;
    rebuild)
      #TODO: See if compose file has a build context?
      docker compose down && docker compose build . && docker compose up -d
      ;;
    reload)
      docker compose down && docker compose up -d
      ;;
    shell)
      if [ -z $2 ]; then
        usage
      else
        if docker exec $2 /bin/bash > /dev/null 2>&1; then
          ok "Starting /bin/bash in $2"
          docker exec -it $2 /bin/bash
        elif docker exec $2 /bin/sh > /dev/null 2>&1; then
          warn "$2 does not support /bin/bash, using /bin/sh"
          docker exec -it $2 /bin/sh
        else
          error "Unable to spawn shell session for $2"
          return 1
        fi
      fi
      ;;
    *)
      usage
      ;;
  esac
}

dutil "$@"