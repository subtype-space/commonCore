# commonCoreSh
A collection of Bash scripts/utilities that one can source in their own bash scripts. This feature set is currently UNSTABLE and is not recommended for use in production.

# HOW TO USE
Use at your own direction, so long it is NOT utilized in closed source applications.

Make sure you download the repository as is, and to not change any files in the resulting directories.
If you want to take advantage of these scripts, source `sourcecore.sh`, or consider sourcing it in your profile via `source sourcecore.sh`

# FEATURES
## comphash
comphash performs an md5sum comparison between two files. It will not perform this operation if it detects either argument as a directory.

## dutil (docker util)
The most useful utility so far. Performs some docker compose based actions, such as bouncing a service, building then bouncing, or allowing for easier container ps searching.
Might be ported over as it's own standalone package. maybe not.

One of the most useful is the shortcut of `dutil shell [container name]`, which does the equivalent of `docker exec -it [container name] /bin/bash`. If the container does not support /bin/bash, it will fallback to using /bin/sh instead.

## initdocker
initdocker creates a couple of Docker files on your behalf, such as a skeleton Compose file, an empty Dockerfile, and some starter Bash scripts.
If you're intimately familiar with Docker, you probably won't need to use the bash scripts and can rely on the functions `dutil` offers.

## logging
Sourcing the library will let you utilize a couple logging notations in your scripts