#!/bin/bash -ex

# PKG_NAME="ungoogled-chromium"
CONCURRENCY="$(nproc)"
OUT_DIR="/out"

wget "https://aur.archlinux.org/cgit/aur.git/snapshot/${PKG_NAME}.tar.gz"
tar zxvf "${PKG_NAME}.tar.gz"
cd "${PKG_NAME}"
sed -i -E "s/^(\s*)([a-z])?make(\s+|$)/\1\2make -j${CONCURRENCY}\3/" PKGBUILD

makepkg --noconfirm -s
cp ./*.tar.xz "$OUT_DIR/"
