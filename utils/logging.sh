#!/bin/bash
# Author: Andrew Subowo
# Some common core scripts I use on a day to day basis that I find helpful
# @_subtype / subtype / 2023
# To use the functions in this script, merely source it (e.g. source <script aname>)

# COLOR PARAMS



# General info
function info() {
    echo -e "[INFO] ${1}"
}

function ok() {
    echo -e "[ OK ] ${1}"
}

# General warn
function warn() {
    echo -e "[WARN] ${1}"
}

# General fatal, returns RC 1
function fatal() {
    echo -e "[FAIL] ${1}"
    exit 1
}

# General error, returns RC of 2
function error() {
    echo -e "[FAIL] ${1}"
    return 2
}