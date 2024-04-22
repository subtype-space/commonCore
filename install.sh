#!/bin/bash
# Author: Andrew Subowo
# @_subtype / subtype / 2024
# Installation script to install dutil into /usr/local/bin


echo "Installing dockerutil"
## TODO: Check for updates?

# Get directory where this file is currently
SCRIPTPATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
ln -sf $SCRIPTPATH/bash/bin/dutil.sh /usr/local/bin/dutil && echo "Installed as dockerutil" || echo "There was an error installing." && exit 1