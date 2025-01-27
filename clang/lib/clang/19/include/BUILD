load(":outs.bzl", "OUTS", "OUTS_TARGETS")

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
    name = "lib-clang-19-include",
    srcs = OUTS_TARGETS,
)

filegroup(
    name = "clang-includes",
    srcs = [
        "//clang/lib/clang/19/include:lib-clang-19-include",
        "//clang/lib/clang/19/include/cuda_wrappers:lib-clang-19-include-cuda_wrappers",
        "//clang/lib/clang/19/include/cuda_wrappers/bits:lib-clang-19-include-cuda_wrappers-bits",
        "//clang/lib/clang/19/include/fuzzer:lib-clang-19-include-fuzzer",
        "//clang/lib/clang/19/include/llvm_libc_wrappers:lib-clang-19-include-llvm_libc_wrappers",
        "//clang/lib/clang/19/include/openmp_wrappers:lib-clang-19-include-openmp_wrappers",
        "//clang/lib/clang/19/include/orc:lib-clang-19-include-orc",
        "//clang/lib/clang/19/include/ppc_wrappers:lib-clang-19-include-ppc_wrappers",
        "//clang/lib/clang/19/include/profile:lib-clang-19-include-profile",
        "//clang/lib/clang/19/include/sanitizer:lib-clang-19-include-sanitizer",
        "//clang/lib/clang/19/include/xray:lib-clang-19-include-xray",
        "//clang/lib/clang/19/include/zos_wrappers:lib-clang-19-include-zos_wrappers",
    ],
)
