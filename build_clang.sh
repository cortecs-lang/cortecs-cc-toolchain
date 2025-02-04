#!/bin/bash
set -ex

ROOT_DIR=$(pwd)

# ===============================
# || Clone alpine package repo ||
# ===============================
APORTS=$ROOT_DIR/aports
git clone --depth 1 https://gitlab.alpinelinux.org/alpine/aports.git $APORTS

# ==================================
# || Get LLVM version from aports ||
# ==================================
LLVM_DIRS=$(find $APORTS/main -maxdepth 1 -type d -name 'llvm[0-9]*')
LATEST_LLVM_MAJOR_VERSION=0
for DIR in $LLVM_DIRS; do
    VERSION=$(basename $DIR | grep -o '[0-9]\+')
    if (( VERSION > LATEST_LLVM_MAJOR_VERSION )); then
        LATEST_LLVM_MAJOR_VERSION=$VERSION
    fi
done
echo "LATEST_LLVM_MAJOR_VERSION=$LATEST_LLVM_MAJOR_VERSION"

APORTS_LLVM_DIR=$APORTS/main/llvm$LATEST_LLVM_MAJOR_VERSION
APORTS_LLVM_RUNTIMES_DIR=$APORTS/main/llvm-runtimes
APORTS_CLANG_DIR=$APORTS/main/clang$LATEST_LLVM_MAJOR_VERSION

LLVM_VERSION=$(cat $APORTS_LLVM_DIR/APKBUILD | grep "pkgver=" | cut -d'=' -f2 | tr -d '[:space:]')
echo "LLVM_VERSION=$LLVM_VERSION"

# ===============================
# || Download LLVM source code ||
# ===============================
LLVM_PROJECT=$ROOT_DIR/llvm-project
mkdir $LLVM_PROJECT
wget https://github.com/llvm/llvm-project/releases/download/llvmorg-${LLVM_VERSION}/llvm-project-${LLVM_VERSION}.src.tar.xz
# --strip-components=1: the llvm tarball contains a top-level directory named llvm-project-<version>.src
#                       we want to extract the contents of it directly into the llvm-project directory.
tar --strip-components=1 -xvf llvm-project-${LLVM_VERSION}.src.tar.xz -C $LLVM_PROJECT

# ==================================================
# || Move patches from aports to LLVM source code ||
# ==================================================
cp -v $APORTS_LLVM_DIR/*.patch $LLVM_PROJECT
cp -v $APORTS_LLVM_RUNTIMES_DIR/*.patch $LLVM_PROJECT
cp -v $APORTS_CLANG_DIR/*.patch $LLVM_PROJECT/clang

# =======================================
# || Apply patches to LLVM source code ||
# =======================================
# to git apply patches, it needs to be a git repo
# it takes way longer to git clone llvm than to download the tarball
git config --global user.email "nobody@example.com"
git config --global user.name "nobody"
cd $LLVM_PROJECT
git init
git add .
git commit -m "Dummy commit to apply patches"

for patch in *.patch; do
    git apply --check $patch
    git apply $patch
done

pushd $LLVM_PROJECT/clang
for patch in *.patch; do
    git apply --check $patch
    git apply $patch
done
popd

CC=clang
CXX=clang++
    #   -DLLVM_BUILD_LLVM_DYLIB=OFF \
    #   -DLLVM_BUILD_SHARED_LIBS=OFF \
    #   -DLIBCLANG_BUILD_STATIC=ON \

cmake -G Ninja -S llvm -B build \
      -DLLVM_ENABLE_PROJECTS="clang;lld" \
      -DLLVM_ENABLE_PIC=OFF \
      -DBUILD_SHARED_LIBS=OFF \
      -DCMAKE_C_FLAGS="-static" \
      -DCMAKE_CXX_FLAGS="-static -Wno-attributes -Wno-dangling-reference -Wno-alloc-size-larger-than -Wno-implicit-fallthrough -Wno-array-bounds" \
      -DCMAKE_C_STANDARD=11 \
      -DCMAKE_BUILD_TYPE=Release

ninja -C build || /bin/true