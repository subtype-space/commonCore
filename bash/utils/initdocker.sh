#!/bin/bash -
# Author: Andrew Subowo
# Some common core scripts I use on a day to day basis that I find helpful
# @_subtype / subtype / 2024
# This script will create a Dockerfile, an optional docker-compose.yml, and a couple of utility shell scripts to aid


function createBuild() {
    info "Creating your build scripts"
    cat << 'EOF' > ./build.sh
#!/bin/bash
# Shell script to build image
docker build . -t
EOF
}

function createDockerComposeUtils() {
    info "Creating your docker-compose utility scripts"
    cat << 'EOF' > ./buildandrestart.sh
#!/bin/bash
# Shell script to run a docker compose build, then restarts your stack, detatched
docker-compose build && docker-compose down && docker-compose up -d && info "Stack restarted"
EOF
}

function createDockerCompose() {
    info "Creating docker-compose.yml"
    cat << 'EOF' > ./docker-compose.yml
version: "3.8"

services:
    $SERVICE_NAME:
        build:
            context: .
        container_name: $CONTAINER_NAME
        image: 
        restart: unless-stopped

EOF
}

# Main function
function initdocker() {
    touch Dockerfile


    read -p 'What is the service name?' SERVICE_NAME 
    read -p 'What is the container name?' CONTAINER_NAME

    createDockerCompose

}




