#!/bin/bash

PATH="/usr/sbin:/usr/bin:/sbin:/bin"

BASE="$(dirname $(realpath -e "$0"))"

cd "$BASE" || { echo "cannot chdir to $BASE" >&2; exit 1; }

mkdir -p "./data"

install -d "./data/database"
install -d "./data/database_dump"
install -d "./data/nextcloud"
install -d "./data/nextcloud_data"
install -d "./data/apache"
install -d "./data/clamav"
install -d "./data/redis"
install -d "./data/elasticsearch"
install -d "./data/collabora_fonts"
install -d "./data/onlyoffice"
