load("@linux-x86_64//:libclang-libs.bzl", "LIBCLANG_LIBS_OUTS")
load("@rules_cc//cc/toolchains:tool.bzl", "cc_tool")
load("@rules_cc//cc/toolchains:tool_map.bzl", "cc_tool_map")
load(":libclang-includes.bzl", "LIBCLANG_INCLUDES_OUTS")

package(default_visibility = ["//visibility:public"])

# quickly writing down some things before I forget. I need to go back and better document all this
# I had to move libc++.a and libunwind.a from clang to sysroot
cc_tool_map(
    name = "all_tools",
    tools = {
        "@rules_cc//cc/toolchains/actions:ar_actions": ":llvm-ar",
        "@rules_cc//cc/toolchains/actions:assembly_actions": ":clang++",
        "@rules_cc//cc/toolchains/actions:c_compile": ":clang",
        "@rules_cc//cc/toolchains/actions:cpp_compile_actions": ":clang++",
        "@rules_cc//cc/toolchains/actions:link_actions": ":lld",
        "@rules_cc//cc/toolchains/actions:objcopy_embed_data": ":llvm-objcopy",
        "@rules_cc//cc/toolchains/actions:strip": ":llvm-strip",
    },
)

cc_tool(
    name = "clang",
    src = select({
        "//conditions:default": "//clang/bin:clang",
    }),
    data = [":libclang-includes"],
)

cc_tool(
    name = "clang++",
    src = select({
        "//conditions:default": "//clang/bin:clang++",
    }),
)

cc_tool(
    name = "lld",
    src = select({
        "//constraint:linux_x86_64": "//clang/bin:clang++",
    }),
    data = select({
        "//constraint:linux_x86_64": [
            ":libclang-libs-linux-x86_64",
            "//clang/bin:linker-files",
        ],
    }),
)

cc_tool(
    name = "llvm-ar",
    src = select({
        "//conditions:default": "//clang/bin:llvm-ar",
    }),
)

cc_tool(
    name = "llvm-objcopy",
    src = select({
        "//conditions:default": "//clang/bin:llvm-objcopy",
    }),
)

cc_tool(
    name = "llvm-objdump",
    src = select({
        "//conditions:default": "//clang/bin:llvm-objdump",
    }),
)

cc_tool(
    name = "llvm-strip",
    src = select({
        "//conditions:default": "//clang/bin:llvm-strip",
    }),
)

genrule(
    name = "libclang-includes",
    srcs = ["libclang-includes.tar.xz"],
    outs = LIBCLANG_INCLUDES_OUTS,
    cmd = "tar xvf $(location libclang-includes.tar.xz) -C $(RULEDIR)",
    tags = ["no-remote-cache"],
)

genrule(
    name = "libclang-libs-linux-x86_64",
    srcs = ["@linux-x86_64//:libclang-libs.tar.xz"],
    outs = LIBCLANG_LIBS_OUTS,
    cmd = "tar xvf $(location @linux-x86_64//:libclang-libs.tar.xz) -C $(RULEDIR)",
    tags = ["no-remote-cache"],
)
