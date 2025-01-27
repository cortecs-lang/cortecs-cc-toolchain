#!/bin/bash

BASE_DIR=$1

function tar_all_files() {
    DIR=$1
    NAME=$2

    pushd $DIR

    FILES=$(find . -maxdepth 1 -type f)

    tar -cJf outs.tar.xz $FILES

    echo "OUTS = [" > outs.bzl
    for file in $FILES; do
        echo "    \"${file:2}\"," >> outs.bzl
    done
    echo "]" >> outs.bzl
    echo "" >> outs.bzl

    echo "OUTS_TARGETS = [" >> outs.bzl
    for file in $FILES; do
        echo "    \":${file:2}\"," >> outs.bzl
    done
    echo "]" >> outs.bzl

    echo "load(\":outs.bzl\", \"OUTS\")" >> BUILD
    echo "load(\":outs.bzl\", \"OUTS_TARGETS\")" >> BUILD
    echo "" >> BUILD
    echo "package(default_visibility = [\"//visibility:public\"])" >> BUILD
    echo "" >> BUILD
    echo "genrule(" >> BUILD
    echo "    name = \"extract\"," >> BUILD
    echo "    srcs = [\":outs.tar.xz\"]," >> BUILD
    echo "    outs = OUTS," >> BUILD
    echo "    cmd = \"tar xf \$(location :outs.tar.xz) -C \$(@D)\"," >> BUILD
    echo "    tags = [\"no-remote-cache\"]," >> BUILD
    echo "    visibility = [\"//visibility:public\"]," >> BUILD
    echo ")" >> BUILD
    echo "" >> BUILD
    echo "filegroup(" >> BUILD
    echo "    name = \"$NAME\"," >> BUILD
    echo "    srcs = OUTS_TARGETS," >> BUILD
    echo ")" >> BUILD

    rm -f $FILES

    popd
}

echo "filegroup(" >> BUILD
echo "    name = \"clang-includes\"," >> BUILD
echo "    srcs = [" >> BUILD

for subdir in $(find "$BASE_DIR" -type d); do
    echo "In $subdir"
    subdir_name=$(echo "$subdir" | sed 's|/|-|g')
    echo "Modified subdir name: $subdir_name"
    tar_all_files $subdir $subdir_name
    echo "        \"//clang/$subdir:$subdir_name\"," >> BUILD
done

echo "    ]" >> BUILD
echo ")" >> BUILD