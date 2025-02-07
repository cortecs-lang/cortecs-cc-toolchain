load("@alpine-x86_64//:libc++-dev.bzl", "LIBCXX_DEV_OUTS")
load("@alpine-x86_64//:libc++-static.bzl", "LIBCXX_STATIC_OUTS")
load("@alpine-x86_64//:libunwind-dev.bzl", "LIBUNWIND_DEV_OUTS")
load("@alpine-x86_64//:libunwind-static.bzl", "LIBUNWIND_STATIC_OUTS")
load("@alpine-x86_64//:musl-dev.bzl", "MUSL_DEV_OUTS")
load("@alpine-x86_64//:xz-dev.bzl", "XZ_DEV_OUTS")
load("@alpine-x86_64//:xz-static.bzl", "XZ_STATIC_OUTS")
load("@bazel_skylib//rules/directory:directory.bzl", "directory")
load("@bazel_skylib//rules/directory:subdirectory.bzl", "subdirectory")

package(default_visibility = ["//visibility:public"])

# required for c++ builds
genrule(
    name = "alpine-libc++-dev",
    srcs = ["@alpine-x86_64//:libc++-dev-19.1.4-r0.apk"],
    outs = LIBCXX_DEV_OUTS,
    cmd = "tar xf $(location @alpine-x86_64//:libc++-dev-19.1.4-r0.apk) -C $(RULEDIR) &> /dev/null",
    tags = ["no-remote-cache"],
)

genrule(
    name = "alpine-libc++-static",
    srcs = ["@alpine-x86_64//:libc++-static-19.1.4-r0.apk"],
    outs = LIBCXX_STATIC_OUTS,
    cmd = "tar xf $(location @alpine-x86_64//:libc++-static-19.1.4-r0.apk) -C $(RULEDIR) &> /dev/null",
    tags = ["no-remote-cache"],
)

# required by libc++
genrule(
    name = "alpine-libunwind-dev",
    srcs = ["@alpine-x86_64//:libunwind-dev-1.8.1-r0.apk"],
    outs = LIBUNWIND_DEV_OUTS,
    cmd = "tar xf $(location @alpine-x86_64//:libunwind-dev-1.8.1-r0.apk) -C $(RULEDIR) &> /dev/null",
    tags = ["no-remote-cache"],
)

genrule(
    name = "alpine-libunwind-static",
    srcs = ["@alpine-x86_64//:libunwind-static-1.8.1-r0.apk"],
    outs = LIBUNWIND_STATIC_OUTS,
    cmd = "tar xf $(location @alpine-x86_64//:libunwind-static-1.8.1-r0.apk) -C $(RULEDIR) &> /dev/null",
    tags = ["no-remote-cache"],
)

# required for c/c++ builds
genrule(
    name = "alpine-musl-dev",
    srcs = ["@alpine-x86_64//:musl-dev-1.2.5-r8.apk"],
    outs = MUSL_DEV_OUTS,
    cmd = "tar xf $(location @alpine-x86_64//:musl-dev-1.2.5-r8.apk) -C $(RULEDIR) &> /dev/null",
    tags = ["no-remote-cache"],
)

genrule(
    name = "alpine-xz-dev",
    srcs = ["@alpine-x86_64//:xz-dev-5.6.4-r0.apk"],
    outs = XZ_DEV_OUTS,
    cmd = "tar xf $(location @alpine-x86_64//:xz-dev-5.6.4-r0.apk) -C $(RULEDIR) &> /dev/null",
    tags = ["no-remote-cache"],
)

# required for libunwind.
# I was seeing missing lzma_stream_* and lzma_index_* symbols without this.
genrule(
    name = "alpine-xz-static",
    srcs = ["@alpine-x86_64//:xz-static-5.6.4-r0.apk"],
    outs = XZ_STATIC_OUTS,
    cmd = "tar xf $(location @alpine-x86_64//:xz-static-5.6.4-r0.apk) -C $(RULEDIR) &> /dev/null",
    tags = ["no-remote-cache"],
)

directory(
    name = "root",
    srcs = [
        ":alpine-libc++-dev",
        ":alpine-libc++-static",
        ":alpine-libunwind-dev",
        ":alpine-libunwind-static",
        ":alpine-musl-dev",
        ":alpine-xz-dev",
        ":alpine-xz-static",
    ],
)

subdirectory(
    name = "usr-include",
    parent = ":root",
    path = "usr/include",
)

subdirectory(
    name = "usr-include-c++-v1",
    parent = ":root",
    path = "usr/include/c++/v1",
)

subdirectory(
    name = "usr-lib",
    parent = ":root",
    path = "usr/lib",
)
