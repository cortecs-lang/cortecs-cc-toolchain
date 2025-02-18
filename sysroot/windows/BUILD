load("@bazel_skylib//rules/directory:directory.bzl", "directory")
load("@bazel_skylib//rules/directory:subdirectory.bzl", "subdirectory")
load("@windows-sysroot-x86_64//:msvcrt-headers.bzl", "MSVCRT_HEADERS_OUTS")
load("@windows-sysroot-x86_64//:ucrt.bzl", "UCRT_OUTS")

package(default_visibility = ["//visibility:public"])

genrule(
    name = "msvcrt-headers",
    srcs = ["@windows-sysroot-x86_64//:msvcrt-headers.tar.xz"],
    outs = MSVCRT_HEADERS_OUTS,
    cmd_bat = "tar xvf $(location @windows-sysroot-x86_64//:msvcrt-headers.tar.xz) -C $(RULEDIR)",
    tags = ["no-remote-cache"],
)

genrule(
    name = "ucrt",
    srcs = ["@windows-sysroot-x86_64//:ucrt.tar.xz"],
    outs = UCRT_OUTS,
    cmd_bat = "tar xvf $(location @windows-sysroot-x86_64//:ucrt.tar.xz) -C $(RULEDIR)",
    tags = ["no-remote-cache"],
)

directory(
    name = "root",
    srcs = [
        ":msvcrt-headers",
        ":ucrt",
    ],
)

subdirectory(
    name = "include",
    parent = ":root",
    path = "include",
)

subdirectory(
    name = "lib",
    parent = ":root",
    path = "lib",
)
