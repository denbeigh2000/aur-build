#!/bin/bash -e

# PKG_NAME="qt4"
PKG_NAME="ungoogled-chromium-archlinux"

BASE_IMAGE="archlinux/base"
CONTAINER_NAME="arch-build"
IMAGE_NAME="denbeigh/arch-build"
OUT_DIR="$(pwd)/out"

if docker ps -a | egrep "$CONTAINER_NAME\$" >/dev/null
then
    echo "Removing old container" >&2
    docker rm "$CONTAINER_NAME"
fi

docker pull $BASE_IMAGE

mkdir -p "$OUT_DIR"
chmod 777 "$OUT_DIR"
docker build -t "$IMAGE_NAME" .
docker run \
    --name "$CONTAINER_NAME" \
    -v "$OUT_DIR":/tmp/asset-dir \
    -e "PKG_NAME=$PKG_NAME" \
    "$IMAGE_NAME"
