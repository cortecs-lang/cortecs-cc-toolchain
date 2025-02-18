load("@bazel_skylib//rules/directory:directory.bzl", "directory")
load("@bazel_skylib//rules/directory:subdirectory.bzl", "subdirectory")
load("@windows-sysroot-x86_64//:msvcrt-headers.bzl", "MSVCRT_HEADERS_OUTS")
load("@windows-sysroot-x86_64//:ucrt-headers.bzl", "UCRT_HEADERS_OUTS")

package(default_visibility = ["//visibility:public"])

genrule(
    name = "msvcrt-headers",
    srcs = ["@windows-sysroot-x86_64//:msvcrt-headers.tar.xz"],
    outs = MSVCRT_HEADERS_OUTS,
    cmd_bat = "tar xvf $(location @windows-sysroot-x86_64//:msvcrt-headers.tar.xz) -C $(RULEDIR)",
    tags = ["no-remote-cache"],
)

genrule(
    name = "ucrt-headers",
    srcs = ["@windows-sysroot-x86_64//:ucrt-headers.tar.xz"],
    outs = UCRT_HEADERS_OUTS,
    cmd_bat = "tar xvf $(location @windows-sysroot-x86_64//:ucrt-headers.tar.xz) -C $(RULEDIR)",
    tags = ["no-remote-cache"],
)

directory(
    name = "root",
    srcs = [
        ":msvcrt-headers",
        ":ucrt-headers",
    ],
)

subdirectory(
    name = "include",
    parent = ":root",
    path = "include",
)
