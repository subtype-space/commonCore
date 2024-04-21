#!/bin/bash -
# Author: Andrew Subowo
# Some common core scripts I use on a day to day basis that I find helpful
# @_subtype / subtype / 2024
# This script will create a Dockerfile, an optional docker-compose.yml, and a couple of utility shell scripts to aid
# Let's be honest, if you're familiar with Docker, you probably won't even need these scripts. These scripts may help those who want to 'standardize' a toolchain or process.

# Generate dummy build script
# TODO: Add proper tags
function createBuildScripts() {
  info "Creating your build scripts"
  cat << 'EOF' > ./build.sh
#!/bin/bash
# Shell script to build image
docker compose build
EOF

  chmod 755 ./build.sh
}

function createDockerComposeUtils() {
  info "Creating your docker-compose utility scripts"
  cat << 'EOF' > ./buildandrestart.sh
#!/bin/bash
# Shell script to run a docker compose build, then restarts your stack, detatched
docker compose build && ok "Build successful" && docker compose down && docker compose up -d && info "Stack restarted"
EOF
  chmod 755 ./buildandrestart.sh

  info "Creating restart script"
  cat << 'EOF' > ./restart.sh
#!/bin/bash
# Shell script to restart the services defined in the respective compose file
docker compose down && docker compose up -d && info "Container(s) restarted"
EOF

  chmod 755 ./restart.sh
}

function createDockerCompose() {
  # Don't overwrite an existing compose file
  if [ -f ./docker-compose.yml ]; then
    info "A compose file already exists"
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
function initdocker() {
  if [ ! -f ./Dockerfile ]; then
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
  createDockerComposeUtils
  createBuildScripts
}




