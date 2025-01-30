load("@rules_cc//cc/toolchains:args.bzl", "cc_args")
load("@rules_cc//cc/toolchains/args:sysroot.bzl", "cc_sysroot")

cc_sysroot(
    name = "linux_sysroot",
    data = [
        "//sysroot:root",
        "//sysroot:usr-include",
        "//sysroot:usr-include-x86_64-linux-gnu",
    ],
    sysroot = "//sysroot:root",
    visibility = ["//visibility:public"],
)

cc_args(
    name = "no_canonical_prefixes",
    actions = [
        "@rules_cc//cc/toolchains/actions:c_compile",
        "@rules_cc//cc/toolchains/actions:cpp_compile_actions",
    ],
    args = ["-no-canonical-prefixes"],
    visibility = ["//visibility:public"],
)
