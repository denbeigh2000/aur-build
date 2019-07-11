#!/bin/bash -ex

OUT_DIR="/tmp/asset-dir"
# PKG_NAME="ungoogled-chromium"
CONCURRENCY="$(nproc)"

wget "https://aur.archlinux.org/cgit/aur.git/snapshot/${PKG_NAME}.tar.gz"
tar zxvf "${PKG_NAME}.tar.gz"
cd "${PKG_NAME}"
sed -i -E "s/^(\s*)([a-z])?make(\s+|$)/\1\2make -j${CONCURRENCY}\3/" PKGBUILD

makepkg --noconfirm -s
cp ./*.tar.xz "$OUT_DIR/"
