#!/bin/sh

set -eu

name="Mathics3"
version="$(rpm -q --qf '%{VERSION}\n' --specfile python-mathics3.spec | head -1)"
srcdir="${name}-${version}"
tarball="${srcdir}.tar.gz"
url="https://files.pythonhosted.org/packages/source/M/${name}/${tarball}"

curdir="$PWD"
workdir="$(mktemp -d)"
trap 'rm -rf "$workdir"' EXIT

wget -O "${workdir}/${tarball}" "$url"
tar xvzf "$workdir/$tarball" -C "$workdir"
# https://github.com/Mathics3/mathics-core/pull/731
rm "${workdir}/${srcdir}/mathics/data/ExampleData/lena.tif"
wget -O ${workdir}/${srcdir}/mathics/data/ExampleData/hedy.tif https://github.com/Mathics3/mathics-core/raw/46e8a073b066dd273c8afc5ec67b6a88ebcf9ced/mathics/data/ExampleData/hedy.tif
(cd "$workdir"; tar cvzf "${curdir}/${tarball}" "${srcdir}")
