load("@alpine-x86_64//:musl-dev.bzl", "MUSL_DEV_OUTS")
load("@bazel_skylib//rules/directory:directory.bzl", "directory")
load("@bazel_skylib//rules/directory:subdirectory.bzl", "subdirectory")

package(default_visibility = ["//visibility:public"])

genrule(
    name = "alpine-musl-dev",
    srcs = ["@alpine-x86_64//:musl-dev-1.2.5-r8.apk"],
    outs = MUSL_DEV_OUTS,
    cmd = "tar xvf $(location @alpine-x86_64//:musl-dev-1.2.5-r8.apk) -C $(RULEDIR)",
    tags = ["no-remote-cache"],
)

directory(
    name = "root",
    srcs = [
        ":alpine-musl-dev",
    ],
)

subdirectory(
    name = "usr-include",
    parent = ":root",
    path = "usr/include",
)

subdirectory(
    name = "usr-lib",
    parent = ":root",
    path = "usr/lib",
)
