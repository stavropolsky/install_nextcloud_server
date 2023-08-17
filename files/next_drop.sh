#!/bin/bash

PATH="/usr/sbin:/usr/bin:/sbin:/bin"

BASE="$(dirname $(realpath -e "$0"))"

cd "$BASE" || { echo "cannot chdir to $BASE" >&2; exit 1; }

for v in "apache" "nextcloud" "imaginary" "fulltextsearch" "redis" \
         "database" "collabora" "clamav" "talk" "domaincheck" "mastercontainer"; do
    docker kill "nextcloud-aio-${v}"
    docker rm   "nextcloud-aio-${v}"
done

for v in "apache" "collabora_fonts" "database" "database_dump" "onlyoffice" \
         "elasticsearch" "mastercontainer" "nextcloud" "nextcloud_data" \
         "redis" "clamav"; do
    docker volume rm "nextcloud_aio_${v}" --force
done

for v in ""; do
    docker network rm "nextcloud-aio${v}"
done

rm -rf "./data"; mkdir -p "./data"; mkdir -p "./mnt" 

./next_init.sh
