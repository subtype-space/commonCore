#!/bin/bash -
# Author: Andrew Subowo
# Some common core scripts I use on a day to day basis that I find helpful
# @_subtype / subtype / 2024
# This script will create a Dockerfile, an optional docker-compose.yml, and a couple of utility shell scripts to aid
# Let's be honest, if you're familiar with Docker, you probably won't even need these scripts. These scripts may help those who want to 'standardize' a toolchain or process.

function createDockerCompose() {
  # Don't overwrite an existing compose file
  if [ -f ./docker-compose.yml ]; then
    ok "A compose file already exists"
  else
    info "Creating docker-compose.yml"
    cat > ./docker-compose.yml << EOT
version: "3.9"

services:
  ${SERVICE_NAME}:
    build:
      context: .
    container_name: ${CONTAINER_NAME}
    image: #your_image_name_here
    restart: unless-stopped
EOT
  unset SERVICE_NAME
  unset CONTAINER_NAME
  fi
}

# Main function
# quick and dirty
function dockerinit() {
  if [ -f ./Dockerfile ]; then
    ok "A Dockerfile already exists"
  else  
    info "Creating Dockerfile"
    touch Dockerfile
  fi

  if [ ! -z "$1" ]; then
    SERVICE_NAME=$1
  else
    SERVICE_NAME="<service name>"
  fi

  if [ ! -z "$2" ]; then
    CONTAINER_NAME=$2
  else
    CONTAINER_NAME="<container name>"
  fi
  createDockerCompose
}




