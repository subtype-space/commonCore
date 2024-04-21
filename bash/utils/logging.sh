#!/bin/bash
# Author: Andrew Subowo
# Some common core scripts I use on a day to day basis that I find helpful
# @_subtype / subtype / 2023
# To use the functions in this script, merely source it (e.g. source <script aname>)

# Constants for colors for better user feedback
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NORM='\033[0m'
BFR='\\r\\033[K'

# TODO: For writing to file, allow disabling of TTY coloring to declutter
# General info
function info() {
    echo -e "[ INFO ] $1"
}

function ok() {
    echo -e "[  ${GREEN}OK${NORM}  ] $1"
}

# General warn
function warn() {
    echo -e "[ ${YELLOW}WARN${NORM} ] $1"
}

# General fatal message. Will exit and return 1
function fatal() {
    echo -e "[ ${RED}FAIL${NORM} ] $1"
    exit 1
}

# General error
function error() {
    echo -e "[ ${RED}FAIL${NORM} ] $1"
    return 1
}