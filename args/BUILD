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
    ],
    args = [
        "-nostdinc",
        "-nostdlib",
        "-nodefaultlibs",
    ],
    visibility = ["//visibility:public"],
)

cc_args(
    name = "nostd++",
    actions = [
        "@rules_cc//cc/toolchains/actions:cpp_compile_actions",
    ],
    args = [
        "-nostdinc++",
        "-nostdlib++",
    ],
    visibility = ["//visibility:public"],
)

cc_args(
    name = "nostd_link",
    actions = [
        "@rules_cc//cc/toolchains/actions:link_actions",
    ],
    args = [
        "-nostdinc",
        "-nostdlib",
        "-nodefaultlibs",
        "-nostdinc++",
        "-nostdlib++",
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
    name = "link-general",
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
        "-pthread",
    ],
    format = {
        "usr_lib": "//sysroot:usr-lib",
    },
    visibility = ["//visibility:public"],
)

cc_args(
    name = "link-executable",
    actions = [
        "@rules_cc//cc/toolchains/actions:link_executable_actions",
    ],
    args = [
        "{usr_lib}/crt1.o",
        "{usr_lib}/crti.o",
        "{usr_lib}/crtn.o",
    ],
    format = {
        "usr_lib": "//sysroot:usr-lib",
    },
    visibility = ["//visibility:public"],
)
