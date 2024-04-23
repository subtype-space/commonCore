#!/bin/bash
# Author: Andrew Subowo
# Some common core scripts I use on a day to day basis that I find helpful
# @_subtype / subtype / 2023
# To use the functions in this script, merely source it (e.g. source <script aname>)
# This script allows one to run an array of scripts in the background

# Take in an array or list of arguments with options
function spinner() {

    COMMAND=$1
    echo $COMMAND
    $COMMAND &
    PID=$!
    I=1
    SPIN="/-\|"
    echo -n ' '
    while [ -d /proc/$PID ]; do
        printf "\b${SPIN:I++%${#SPIN}:1}"
        sleep .1 # DO NOT remove this sleep!
    done
    wait $PID
    return $?

}