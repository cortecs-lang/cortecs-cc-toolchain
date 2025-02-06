load("@rules_cc//cc/toolchains:toolchain.bzl", "cc_toolchain")

package(default_visibility = ["//visibility:public"])

cc_toolchain(
    name = "host_clang",
    args = [
        "//args:no_canonical_prefixes",
        "//args:linux_sysroot",
        "//args:nostd",
        "//args:isystem",
        "//args:link-dirs",
    ],
    enabled_features = ["@rules_cc//cc/toolchains/args:experimental_replace_legacy_action_config_features"],
    known_features = ["@rules_cc//cc/toolchains/args:experimental_replace_legacy_action_config_features"],
    tool_map = "//clang:all_tools",
)

toolchain(
    name = "host_cc_toolchain",
    toolchain = ":host_clang",
    toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
)
