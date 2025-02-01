load("@bazel_skylib//rules/directory:directory.bzl", "directory")
load("@bazel_skylib//rules/directory:subdirectory.bzl", "subdirectory")
load("@ubuntu-x86_64//:libc++-dev.bzl", "LIBCXX_DEV_OUTS")
load("@ubuntu-x86_64//:libc6-dev.bzl", "LIBC6_DEV_OUTS")
load("@ubuntu-x86_64//:libc6.bzl", "LIBC6_OUTS")
load("@ubuntu-x86_64//:libgcc-14-dev.bzl", "LIBGCC_14_DEV_OUTS")
load("@ubuntu-x86_64//:libunwind-dev.bzl", "LIBUNWIND_DEV_OUTS")

package(default_visibility = ["//visibility:public"])

genrule(
    name = "ubuntu-libc++-dev",
    srcs = ["@ubuntu-x86_64//:libc++-dev_6.0-2_amd64.deb"],
    outs = LIBCXX_DEV_OUTS,
    cmd = "$(location @ubuntu-x86_64//:dpkg-deb) -x $(location @ubuntu-x86_64//:libc++-dev_6.0-2_amd64.deb) $(RULEDIR)",
    tags = ["no-remote-cache"],
    tools = ["@ubuntu-x86_64//:dpkg-deb"],
)

genrule(
    name = "ubuntu-libc6",
    srcs = ["@ubuntu-x86_64//:libc6_2.27-3ubuntu1.6_amd64.deb"],
    outs = LIBC6_OUTS,
    cmd = "$(location @ubuntu-x86_64//:dpkg-deb) -x $(location @ubuntu-x86_64//:libc6_2.27-3ubuntu1.6_amd64.deb) $(RULEDIR)",
    tags = ["no-remote-cache"],
    tools = ["@ubuntu-x86_64//:dpkg-deb"],
)

genrule(
    name = "ubuntu-libc6-dev",
    srcs = ["@ubuntu-x86_64//:libc6-dev_2.27-3ubuntu1.6_amd64.deb"],
    outs = LIBC6_DEV_OUTS,
    cmd = "$(location @ubuntu-x86_64//:dpkg-deb) -x $(location @ubuntu-x86_64//:libc6-dev_2.27-3ubuntu1.6_amd64.deb) $(RULEDIR)",
    tags = ["no-remote-cache"],
    tools = ["@ubuntu-x86_64//:dpkg-deb"],
)

genrule(
    name = "ubuntu-libgcc-14-dev",
    srcs = ["@ubuntu-x86_64//:libgcc-14-dev_14.2.0-13ubuntu1_amd64.deb"],
    outs = LIBGCC_14_DEV_OUTS,
    cmd = "$(location @ubuntu-x86_64//:dpkg-deb) -x $(location @ubuntu-x86_64//:libgcc-14-dev_14.2.0-13ubuntu1_amd64.deb) $(RULEDIR)",
    tags = ["no-remote-cache"],
    tools = ["@ubuntu-x86_64//:dpkg-deb"],
)

genrule(
    name = "ubuntu-libunwind-dev",
    srcs = ["@ubuntu-x86_64//:libunwind-dev_1.6.2-3.1_amd64.deb"],
    outs = LIBUNWIND_DEV_OUTS,
    cmd = "$(location @ubuntu-x86_64//:dpkg-deb) -x $(location @ubuntu-x86_64//:libunwind-dev_1.6.2-3.1_amd64.deb) $(RULEDIR)",
    tags = ["no-remote-cache"],
    tools = ["@ubuntu-x86_64//:dpkg-deb"],
)

# directory(
#     name = "root",
#     srcs = glob(["**/*"]),
# )

directory(
    name = "root",
    srcs = [
        ":ubuntu-libc++-dev",
        ":ubuntu-libc6",
        ":ubuntu-libc6-dev",
        ":ubuntu-libgcc-14-dev",
        ":ubuntu-libunwind-dev",
    ],
)

subdirectory(
    name = "usr-include-x86_64-linux-gnu",
    parent = ":root",
    path = "usr/include/x86_64-linux-gnu",
)

subdirectory(
    name = "usr-include",
    parent = ":root",
    path = "usr/include",
)
