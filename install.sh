#!/bin/bash
# Author: Andrew Subowo
# @_subtype / subtype / 2024
# Installation script to install dutil into /usr/local/bin


echo "Installing docker utilities"
## TODO: Check for updates?

# Get directory where this file is currently
SCRIPTPATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
ln -sf $SCRIPTPATH/bin/dutil.sh /usr/local/bin/dutil && echo "Installed as dutil" || echo "There was an error creating the symlink" && exit 1

echo "Running aliases"

if [[ -x $SCRIPTPATH/setupshell.sh ]]; then
    $SCRIPTPATH/setupshell.sh
else
    echo "Couldn't find the setupshell script, or the file isn't executable"
fi