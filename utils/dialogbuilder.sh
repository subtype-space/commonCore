#!/bin/bash
# Author: Andrew Subowo
# Some common core scripts I use on a day to day basis that I find helpful
# @_subtype / subtype / 2023
# To use the functions in this script, merely source it (e.g. source <script aname>)
# This script assists in quickly building dialog boxes with whiptail or dialog

function check() {
    if ! command -v whiptail &> /dev/null; then
        echo "whiptail not installed."
        exit 1
    fi
}

