load("@bazel_skylib//rules/directory:directory.bzl", "directory")
load("@bazel_skylib//rules/directory:subdirectory.bzl", "subdirectory")
load("@windows-sysroot-x86_64//:ucrt-headers.bzl", "UCRT_HEADERS_OUTS")

package(default_visibility = ["//visibility:public"])

genrule(
    name = "ucrt-headers",
    srcs = ["@windows-sysroot-x86_64//:ucrt-headers.tar.xz"],
    outs = UCRT_HEADERS_OUTS,
    cmd_bat = "tar xf $(location @windows-sysroot-x86_64//:ucrt-headers.tar.xz) -C $(RULEDIR) &> /dev/null",
    tags = ["no-remote-cache"],
)

directory(
    name = "root",
    srcs = [
        ":ucrt-headers",
    ],
)

subdirectory(
    name = "include",
    parent = ":root",
    path = "include",
)
