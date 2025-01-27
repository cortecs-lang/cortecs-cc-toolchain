# Problem: Github has incredibly low bandwidth quota for lfs before you have to start paying for it: 1GiB.
#          It would be impossible to run regular CI with this limit.
# Note: there's no bandwith quota for normal checkout
# Problem: standard llvm binaries are too big for a normal github checkin
# Solution: Compress the binaries so they're small enough for normal checkin,
#           and decompress them in the build.
# Note: Currently optimizing for compression ratio for fast checkout in CI.
#       Decompression time doesn't appear to be a limiting factor.

# Problem: With remote caching enabled, Bazel will attempt to download the decompressed binaries
#          from the cache instead of decompressing them locally.
# Solution: Add the "no-remote-cache" tag to all genrules to prevent this.

# Note: The linux x86_64 distribution is just a large llvm binary with a bunch of symlinks.
#       The symlinks are necessary because llvm uses the name of the symlink to determine which tool to use.

package(default_visibility = ["//visibility:public"])

genrule(
    name = "produce_llvm",
    srcs = select({
        "//constraint:linux_x86_64": ["@linux-x86_64//bin:llvm.tar.xz"],
    }),
    outs = ["llvm"],
    cmd = select({
        "//constraint:linux_x86_64": "time tar xf $(location @linux-x86_64//bin:llvm.tar.xz) -C $(@D)",
    }),
    tags = ["no-remote-cache"],
)

genrule(
    name = "produce_clang",
    srcs = select({
        "//constraint:linux_x86_64": [":llvm"],
    }),
    outs = ["clang"],
    cmd = select({
        "//constraint:linux_x86_64": "ln -s llvm $(@D)/clang",
    }),
    tags = ["no-remote-cache"],
)

genrule(
    name = "produce_clang++",
    srcs = select({
        "//constraint:linux_x86_64": [":llvm"],
    }),
    outs = ["clang++"],
    cmd = select({
        "//constraint:linux_x86_64": "ln -s llvm $(@D)/clang++",
    }),
    tags = ["no-remote-cache"],
)

genrule(
    name = "produce_ld_lld",
    srcs = select({
        "//constraint:linux_x86_64": [":llvm"],
    }),
    outs = ["ld.lld"],
    cmd = select({
        "//constraint:linux_x86_64": "ln -s llvm $(@D)/ld.lld",
    }),
    tags = ["no-remote-cache"],
)

genrule(
    name = "produce_ld64_lld",
    srcs = select({
        "//constraint:linux_x86_64": [":llvm"],
    }),
    outs = ["ld64.lld"],
    cmd = select({
        "//constraint:linux_x86_64": "ln -s llvm $(@D)/ld64.lld",
    }),
    tags = ["no-remote-cache"],
)

genrule(
    name = "produce_lld",
    srcs = select({
        "//constraint:linux_x86_64": [":llvm"],
    }),
    outs = ["lld"],
    cmd = select({
        "//constraint:linux_x86_64": "ln -s llvm $(@D)/lld",
    }),
    tags = ["no-remote-cache"],
)

genrule(
    name = "produce_lld-link",
    srcs = select({
        "//constraint:linux_x86_64": [":llvm"],
    }),
    outs = ["lld-link"],
    cmd = select({
        "//constraint:linux_x86_64": "ln -s llvm $(@D)/lld-link",
    }),
    tags = ["no-remote-cache"],
)

genrule(
    name = "produce_llvm-ar",
    srcs = select({
        "//constraint:linux_x86_64": [":llvm"],
    }),
    outs = ["llvm-ar"],
    cmd = select({
        "//constraint:linux_x86_64": "ln -s llvm $(@D)/llvm-ar",
    }),
    tags = ["no-remote-cache"],
)

genrule(
    name = "produce_llvm-objcopy",
    srcs = select({
        "//constraint:linux_x86_64": [":llvm"],
    }),
    outs = ["llvm-objcopy"],
    cmd = select({
        "//constraint:linux_x86_64": "ln -s llvm $(@D)/llvm-objcopy",
    }),
    tags = ["no-remote-cache"],
)

genrule(
    name = "produce_llvm-objdump",
    srcs = select({
        "//constraint:linux_x86_64": [":llvm"],
    }),
    outs = ["llvm-objdump"],
    cmd = select({
        "//constraint:linux_x86_64": "ln -s llvm $(@D)/llvm-objdump",
    }),
    tags = ["no-remote-cache"],
)

genrule(
    name = "produce_llvm-strip",
    srcs = select({
        "//constraint:linux_x86_64": [":llvm"],
    }),
    outs = ["llvm-strip"],
    cmd = select({
        "//constraint:linux_x86_64": "ln -s llvm $(@D)/llvm-strip",
    }),
    tags = ["no-remote-cache"],
)

filegroup(
    name = "linker-files",
    srcs = select({
        "@platforms//os:windows": [],
        "//conditions:default": [
            ":ld.lld",
            ":ld64.lld",
            ":lld",
            ":lld-link",
        ],
    }),
)
