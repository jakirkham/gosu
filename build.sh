#!/bin/bash
set -e

cd "$(dirname "$(readlink -f "$BASH_SOURCE")")"

set -x
docker pull $(awk '/^FROM\s/ { print /:/ ? $2 : $2":latest" }' Dockerfile)
docker build -t gosu .
rm -f gosu* SHA256SUMS*
docker run --rm gosu bash -c 'cd /go/bin && tar -c gosu*' | tar -xv
sha256sum gosu* > SHA256SUMS
cat SHA256SUMS
ls -lFh gosu* SHA256SUMS*
./gosu-$(dpkg --print-architecture)
