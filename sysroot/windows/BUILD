load("@bazel_skylib//rules/directory:directory.bzl", "directory")
load("@bazel_skylib//rules/directory:subdirectory.bzl", "subdirectory")
load("@windows-sysroot-x86_64//:msvcrt-headers.bzl", "MSVCRT_HEADERS_OUTS")
load("@windows-sysroot-x86_64//:ucrt.bzl", "UCRT_OUTS")
load("@windows-sysroot-x86_64//:windows-sdk-headers.bzl", "WINDOWS_SDK_HEADERS_OUTS")
load("@windows-sysroot-x86_64//:windows-shared-headers.bzl", "WINDOWS_SHARED_HEADERS_OUTS")

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

genrule(
    name = "windows-sdk-headers",
    srcs = ["@windows-sysroot-x86_64//:windows-sdk-headers.tar.xz"],
    outs = WINDOWS_SDK_HEADERS_OUTS,
    cmd_bat = "tar xvf $(location @windows-sysroot-x86_64//:windows-sdk-headers.tar.xz) -C $(RULEDIR)",
    tags = ["no-remote-cache"],
)

genrule(
    name = "windows-shared-headers",
    srcs = ["@windows-sysroot-x86_64//:windows-shared-headers.tar.xz"],
    outs = WINDOWS_SHARED_HEADERS_OUTS,
    cmd_bat = "tar xvf $(location @windows-sysroot-x86_64//:windows-shared-headers.tar.xz) -C $(RULEDIR)",
    tags = ["no-remote-cache"],
)

directory(
    name = "root",
    srcs = [
        ":msvcrt-headers",
        ":ucrt",
        ":windows-sdk-headers",
        ":windows-shared-headers",
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
