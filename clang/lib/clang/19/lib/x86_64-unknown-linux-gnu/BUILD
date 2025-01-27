# Problem: clang looks relative to itself for these files and not on the linker search path
# Solution: Extract these files to the correct location
load("@linux-x86_64//lib/clang/19/lib/x86_64-unknown-linux-gnu:libclang-outs.bzl", "LIBCLANG_OUTS")

genrule(
    name = "extract_lib",
    srcs = ["@linux-x86_64//lib/clang/19/lib/x86_64-unknown-linux-gnu:libclang.tar.xz"],
    outs = LIBCLANG_OUTS,
    cmd = "tar xf $(location @linux-x86_64//lib/clang/19/lib/x86_64-unknown-linux-gnu:libclang.tar.xz) -C $(@D)",
    tags = ["no-remote-cache"],
    visibility = ["//visibility:public"],
)
