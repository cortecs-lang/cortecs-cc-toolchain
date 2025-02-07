load("@rules_cc//cc/toolchains:args.bzl", "cc_args")
load("@rules_cc//cc/toolchains/args:sysroot.bzl", "cc_sysroot")

cc_sysroot(
    name = "linux_sysroot",
    data = [
        "//sysroot:root",
        "//sysroot:usr-include",
        "//sysroot:usr-lib",
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

cc_args(
    name = "nostd",
    actions = [
        "@rules_cc//cc/toolchains/actions:c_compile",
        "@rules_cc//cc/toolchains/actions:cpp_compile_actions",
        "@rules_cc//cc/toolchains/actions:link_actions",
    ],
    args = [
        "-nostdinc",
        "-nostdinc++",
        "-nostdlibinc",
        "-nostdlib",
        "-nostdlib++",
        "-nodefaultlibs",
        "-nostartfiles",
        "-v",
    ],
    visibility = ["//visibility:public"],
)

cc_args(
    name = "isystem",
    actions = [
        "@rules_cc//cc/toolchains/actions:c_compile",
        "@rules_cc//cc/toolchains/actions:cpp_compile_actions",
    ],
    args = [
        "-isystem",
        "{cxx_include}",
        "-isystem",
        "{usr_include}",
    ],
    format = {
        "usr_include": "//sysroot:usr-include",
        "cxx_include": "//sysroot:usr-include-c++-v1",
    },
    visibility = ["//visibility:public"],
)

cc_args(
    name = "link-dirs",
    actions = [
        "@rules_cc//cc/toolchains/actions:link_actions",
    ],
    args = [
        # with out this, clang was using /usr/bin/ld over the lld from the toolchain
        # just make sure if youre ever getting a weird linker error, that with -v, lld is being used
        "-fuse-ld=lld",
        "-L{usr_lib}",
        "-lc",
        "-lc++",
        "-lc++abi",
        "-lunwind",
        "-llzma",
        "{usr_lib}/crt1.o",
        "{usr_lib}/crti.o",
        "{usr_lib}/crtn.o",
    ],
    format = {
        "usr_lib": "//sysroot:usr-lib",
    },
    visibility = ["//visibility:public"],
)
