#!/bin/sh
# Builds requests.so from this checkout in Docker and copies it to ./out/.
set -eu
cd "$(dirname "$0")"
docker build -t pawn-requests-oldglibc .
mkdir -p out
id=$(docker create pawn-requests-oldglibc)
docker cp "$id:/src/build/lib/requests.so" out/requests.so
docker rm "$id" >/dev/null
echo "OK: out/requests.so"
