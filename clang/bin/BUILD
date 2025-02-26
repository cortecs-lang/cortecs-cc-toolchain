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

package(default_visibility = ["//visibility:public"])

genrule(
    name = "produce_clang",
    srcs = select({
        "//constraint:linux_x86_64": ["@linux-x86_64//:clang.tar.gz"],
    }),
    outs = ["clang"],
    cmd = select({
        "//constraint:linux_x86_64": "tar xf $(location @linux-x86_64//:clang.tar.gz) -C $(@D)",
    }),
    tags = ["no-remote-cache"],
)

genrule(
    name = "produce_clang_exe",
    srcs = select({
        "//constraint:windows_x86_64": ["@windows-x86_64//:clang.exe.tar.gz"],
    }),
    outs = ["clang.exe"],
    cmd_bat = select({
        "//constraint:windows_x86_64": "tar xf $(location @windows-x86_64//:clang.exe.tar.gz) -C $(@D)",
    }),
    tags = ["no-remote-cache"],
)

genrule(
    name = "produce_clang++",
    srcs = select({
        "//constraint:linux_x86_64": [":clang"],
    }),
    outs = ["clang++"],
    cmd = select({
        "//constraint:linux_x86_64": "ln -s clang $(@D)/clang++",
    }),
    tags = ["no-remote-cache"],
)

genrule(
    name = "produce_clang++_exe",
    srcs = select({
        "//constraint:windows_x86_64": ["@windows-x86_64//:clang++.exe.tar.gz"],
    }),
    outs = ["clang++.exe"],
    cmd_bat = select({
        "//constraint:windows_x86_64": "tar xf $(location @windows-x86_64//:clang++.exe.tar.gz) -C $(@D)",
    }),
    tags = ["no-remote-cache"],
)

genrule(
    name = "produce_llvm-ar",
    srcs = select({
        "//constraint:linux_x86_64": ["@linux-x86_64//:llvm-ar.tar.gz"],
    }),
    outs = ["llvm-ar"],
    cmd = select({
        "//constraint:linux_x86_64": "tar xf $(location @linux-x86_64//:llvm-ar.tar.gz) -C $(@D)",
    }),
    tags = ["no-remote-cache"],
)

genrule(
    name = "produce_llvm-ar_exe",
    srcs = select({
        "//constraint:windows_x86_64": ["@windows-x86_64//:llvm-ar.exe.tar.gz"],
    }),
    outs = ["llvm-ar.exe"],
    cmd_bat = select({
        "//constraint:windows_x86_64": "tar xf $(location @windows-x86_64//:llvm-ar.exe.tar.gz) -C $(@D)",
    }),
    tags = ["no-remote-cache"],
)

genrule(
    name = "produce_llvm-objdump",
    srcs = select({
        "//constraint:linux_x86_64": ["@linux-x86_64//:llvm-objdump.tar.gz"],
    }),
    outs = ["llvm-objdump"],
    cmd = select({
        "//constraint:linux_x86_64": "tar xf $(location @linux-x86_64//:llvm-objdump.tar.gz) -C $(@D)",
    }),
    tags = ["no-remote-cache"],
)

genrule(
    name = "produce_llvm-objdump_exe",
    srcs = select({
        "//constraint:windows_x86_64": ["@windows-x86_64//:llvm-objdump.exe.tar.gz"],
    }),
    outs = ["llvm-objdump.exe"],
    cmd_bat = select({
        "//constraint:windows_x86_64": "tar xf $(location @windows-x86_64//:llvm-objdump.exe.tar.gz) -C $(@D)",
    }),
    tags = ["no-remote-cache"],
)

genrule(
    name = "produce_llvm-objcopy",
    srcs = select({
        "//constraint:linux_x86_64": ["@linux-x86_64//:llvm-objcopy.tar.gz"],
    }),
    outs = ["llvm-objcopy"],
    cmd = select({
        "//constraint:linux_x86_64": "tar xf $(location @linux-x86_64//:llvm-objcopy.tar.gz) -C $(@D)",
    }),
    tags = ["no-remote-cache"],
)

genrule(
    name = "produce_llvm-objcopy_exe",
    srcs = select({
        "//constraint:windows_x86_64": ["@windows-x86_64//:llvm-objcopy.exe.tar.gz"],
    }),
    outs = ["llvm-objcopy.exe"],
    cmd_bat = select({
        "//constraint:windows_x86_64": "tar xf $(location @windows-x86_64//:llvm-objcopy.exe.tar.gz) -C $(@D)",
    }),
    tags = ["no-remote-cache"],
)

genrule(
    name = "produce_llvm-strip",
    srcs = select({
        "//constraint:linux_x86_64": [":llvm-objcopy"],
    }),
    outs = ["llvm-strip"],
    cmd = select({
        "//constraint:linux_x86_64": "ln -s llvm-objcopy $(@D)/llvm-strip",
    }),
    tags = ["no-remote-cache"],
)

genrule(
    name = "produce_llvm-strip_exe",
    srcs = select({
        "//constraint:windows_x86_64": ["@windows-x86_64//:llvm-strip.exe.tar.gz"],
    }),
    outs = ["llvm-strip.exe"],
    cmd_bat = select({
        "//constraint:windows_x86_64": "tar xf $(location @windows-x86_64//:llvm-strip.exe.tar.gz) -C $(@D)",
    }),
    tags = ["no-remote-cache"],
)

filegroup(
    name = "linker-files",
    srcs = select({
        "@platforms//os:windows": [
            ":ld.lld.exe",
            ":ld64.lld.exe",
            ":lld.exe",
            ":lld-link.exe",
        ],
        "//conditions:default": [
            ":ld.lld",
            ":ld64.lld",
            ":lld",
            ":lld-link",
        ],
    }),
)

genrule(
    name = "produce_lld",
    srcs = select({
        "//constraint:linux_x86_64": ["@linux-x86_64//:lld.tar.gz"],
    }),
    outs = ["lld"],
    cmd = select({
        "//constraint:linux_x86_64": "tar xf $(location @linux-x86_64//:lld.tar.gz) -C $(@D)",
    }),
    tags = ["no-remote-cache"],
)

genrule(
    name = "produce_lld_exe",
    srcs = select({
        "//constraint:windows_x86_64": ["@windows-x86_64//:lld.exe.tar.gz"],
    }),
    outs = ["lld.exe"],
    cmd_bat = select({
        "//constraint:windows_x86_64": "tar xf $(location @windows-x86_64//:lld.exe.tar.gz) -C $(@D)",
    }),
    tags = ["no-remote-cache"],
)

genrule(
    name = "produce_ld_lld",
    srcs = select({
        "//constraint:linux_x86_64": [":lld"],
    }),
    outs = ["ld.lld"],
    cmd = select({
        "//constraint:linux_x86_64": "ln -s lld $(@D)/ld.lld",
    }),
    tags = ["no-remote-cache"],
)

genrule(
    name = "produce_ld_lld_exe",
    srcs = select({
        "//constraint:windows_x86_64": ["@windows-x86_64//:ld.lld.exe.tar.gz"],
    }),
    outs = ["ld.lld.exe"],
    cmd_bat = select({
        "//constraint:windows_x86_64": "tar xf $(location @windows-x86_64//:ld.lld.exe.tar.gz) -C $(@D)",
    }),
    tags = ["no-remote-cache"],
)

genrule(
    name = "produce_ld64_lld",
    srcs = select({
        "//constraint:linux_x86_64": [":lld"],
    }),
    outs = ["ld64.lld"],
    cmd = select({
        "//constraint:linux_x86_64": "ln -s lld $(@D)/ld64.lld",
    }),
    tags = ["no-remote-cache"],
)

genrule(
    name = "produce_ld64_lld_exe",
    srcs = select({
        "//constraint:windows_x86_64": ["@windows-x86_64//:ld64.lld.exe.tar.gz"],
    }),
    outs = ["ld64.lld.exe"],
    cmd_bat = select({
        "//constraint:windows_x86_64": "tar xf $(location @windows-x86_64//:ld64.lld.exe.tar.gz) -C $(@D)",
    }),
    tags = ["no-remote-cache"],
)

genrule(
    name = "produce_lld-link",
    srcs = select({
        "//constraint:linux_x86_64": [":lld"],
    }),
    outs = ["lld-link"],
    cmd = select({
        "//constraint:linux_x86_64": "ln -s lld $(@D)/lld-link",
    }),
    tags = ["no-remote-cache"],
)

genrule(
    name = "produce_lld-link_exe",
    srcs = select({
        "//constraint:windows_x86_64": ["@windows-x86_64//:lld-link.exe.tar.gz"],
    }),
    outs = ["lld-link.exe"],
    cmd_bat = select({
        "//constraint:windows_x86_64": "tar xf $(location @windows-x86_64//:lld-link.exe.tar.gz) -C $(@D)",
    }),
    tags = ["no-remote-cache"],
)
