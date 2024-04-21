#!/bin/bash -
# Author: Andrew Subowo
# docker compose based utils -- these can be translated into aliases
# @_subtype / subtype / 2024

function usage() {
  echo "usage: dutil [reload|rebuild|networks|ps|psg] [container name]"
  echo -e "  net|network|networks\n\t\t Returns the list of docker networks"
  echo -e "  ps|psg\n\t\t If given a container name, perform a search for it. psg performs a grep instead against docker ps -a"
  echo -e "  rebuild\n\t\t Performs a docker compose down, build, and up, detatched"
  echo -e "  reload\n\t\t Performs a docker compose down and up, detatched"
  echo "Part of the _subtype common library"
  return 2
}

function dutil() {
  if [ -z $1 ]; then
    usage
    return 2
  fi

  # TODO: Add v1 support, maybe.
  if ! docker compose version &> /dev/null; then
    error "Docker compose v2 is not installed"
    return 1
  fi

  case $1 in
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

    *)
      usage
      ;;
  esac
}