#!/usr/bin/env bash
set -e -u -o pipefail

node="$1"

kubectl -n debug debug "node/${node}" -it --image=docker.io/library/ubuntu -- chroot /host bash
