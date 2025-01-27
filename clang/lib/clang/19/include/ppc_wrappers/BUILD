load(":outs.bzl", "OUTS")
load(":outs.bzl", "OUTS_TARGETS")

package(default_visibility = ["//visibility:public"])

genrule(
    name = "extract",
    srcs = [":outs.tar.xz"],
    outs = OUTS,
    cmd = "tar xf $(location :outs.tar.xz) -C $(@D)",
    tags = ["no-remote-cache"],
    visibility = ["//visibility:public"],
)

filegroup(
    name = "lib-clang-19-include-ppc_wrappers",
    srcs = OUTS_TARGETS,
)
