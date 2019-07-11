#!/bin/bash -ex

OUT_DIR="/out"
if [ -z "$CONCURRENCY" ]
then
    CONCURRENCY="$(nproc)"
fi

if ! touch /out/test_write 2>/dev/null
then
    echo "Cannot write to output directory, will not proceedstopping early." >&2
    exit 1
fi

rm /out/test_write

TARBALL="${PKG_NAME}.tar.gz"
TARBALL_URL="https://aur.archlinux.org/cgit/aur.git/snapshot/${TARBALL}"

wget "$TARBALL_URL"
tar zxvf "$TARBALL"
cd "${PKG_NAME}"
sed -i -E "s/^(\s*)make(\s+|$)/\1make -j${CONCURRENCY}\2/" PKGBUILD

makepkg --noconfirm -s
cp ./*.tar.xz "$OUT_DIR/"
