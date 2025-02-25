load("@rules_cc//cc/toolchains:args.bzl", "cc_args")
load("@rules_cc//cc/toolchains:args_list.bzl", "cc_args_list")

cc_args_list(
    name = "args",
    args = [
        ":no_canonical_prefixes",
        ":nostd",
        # ":nostd++",
        ":nostd_link",
        ":isystem",
        ":link-general",
    ],
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

# I get a bunch of --unused-command-line-argument errors when using this
# TODO: figure out how why
# cc_args(
#     name = "nostd++",
#     actions = [
#         "@rules_cc//cc/toolchains/actions:cpp_compile_actions",
#     ],
#     args = [
#         "-nostdinc++",
#         "-nostdlib++",
#     ],
#     visibility = ["//visibility:public"],
# )

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
        "{cpp_include}",
        "-isystem",
        "{include}",
    ],
    data = [
        "//sysroot/windows:cpp-include",
        "//sysroot/windows:include",
        "//sysroot/windows:root",
    ],
    format = {
        "include": "//sysroot/windows:include",
        "cpp_include": "//sysroot/windows:cpp-include",
    },
    visibility = ["//visibility:public"],
)

cc_args(
    name = "link-general",
    actions = [
        "@rules_cc//cc/toolchains/actions:link_actions",
    ],
    args = [
        # without this, clang was using /some/long/path/to/link.exe over the lld from the toolchain
        # just make sure if youre ever getting a weird linker error, that with -v, lld is being used
        "-fuse-ld=lld",
        "-L{lib}",
        "-llibcmt",
        "-llibcpmt",

        # I was seeing a bunch of missing symbols when linking: creat, open, dup2, etc.
        # When dumping the static ucrt lib, I saw this:
        # (ps) dumpbin /symbols libucrt.lib | Select-String "_dup2"
        # 06D 00000000 SECT34 notype ()    External     | _dup2
        # msvc at some point supported those symbols without the `_`, but now you need
        # this lib to convert the old names to the new names.
        "-loldnames",
    ],
    format = {
        "lib": "//sysroot/windows:lib",
    },
    visibility = ["//visibility:public"],
)
