#!/bin/bash
set -e

ARCH=aarch64
DOCKER_VERSION=20.10.9
DOCKER_DIR=/volume1/@docker

echo "download and copy docker $DOCKER_VERSION-$ARCH in /usr/bin"
curl "https://download.docker.com/linux/static/stable/$ARCH/docker-$DOCKER_VERSION.tgz" | tar -xz --overwrite -C /usr/bin --strip-components=1

echo "create working dir $DOCKER_DIR"
mkdir -p "$DOCKER_DIR"

echo "create config file docker.json"
mkdir -p /etc/docker
cat <<EOT > /etc/docker/daemon.json
{
  "storage-driver": "vfs",
  "iptables": false,
  "data-root": "$DOCKER_DIR"
}
EOT

echo "Follow the RUN DOCKER point"