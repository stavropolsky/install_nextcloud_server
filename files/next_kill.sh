#!/bin/bash

PATH="/usr/sbin:/usr/bin:/sbin:/bin"

BASE="$(dirname $(realpath -e "$0"))"

cd "$BASE" || { echo "cannot chdir to $BASE" >&2; exit 1; }

docker compose kill
