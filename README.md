# commonCoreSh
A collection of Bash scripts/utilities that one can source in their own bash scripts.

# HOW TO USE
Use at your own direction, so long it is NOT utilized in closed source applications.

Make sure you download the repository as is, and to not change any files in the resulting directories.
If you want to take advantage of these scripts, source `sourcecore.sh`, or consider sourcing it in your profile.

# FEATURES

## comphash
comphash performs an md5sum comparison between two files. It will not perform this operation if it detects either argument as a directory.

## initdocker
initdocker creates a skeleton docker 

## logging
Sourcing the library will let you utilize a couple logging notations in your scripts