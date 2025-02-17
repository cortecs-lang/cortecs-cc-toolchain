load("@rules_cc//cc/toolchains:toolchain.bzl", "cc_toolchain")

package(default_visibility = ["//visibility:public"])

cc_toolchain(
    name = "host_clang",
    args = select({
        "@platforms//os:linux": ["//args/linux:args"],
        "@platforms//os:windows": ["//args/windows:args"],
    }),
    enabled_features = ["@rules_cc//cc/toolchains/args:experimental_replace_legacy_action_config_features"],
    known_features = ["@rules_cc//cc/toolchains/args:experimental_replace_legacy_action_config_features"],
    tool_map = "//clang:all_tools",
)

toolchain(
    name = "host_cc_toolchain",
    toolchain = ":host_clang",
    toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
)
