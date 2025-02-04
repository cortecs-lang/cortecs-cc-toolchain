# Use the official Alpine image as a parent image
FROM alpine:latest

RUN apk update
RUN apk add bash git coreutils diffutils sudo \
        musl-dev \
        gcc g++ binutils-dev \
        make cmake ninja-build \
        python3 py3-setuptools \
        libffi-dev openssl-dev \
        ncurses-dev libedit-dev libxml2-dev zlib-dev zlib-static

RUN adduser -D -s /bin/bash clang && \
        echo "clang ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

COPY build_clang.sh /home/clang/build_clang.sh
RUN chmod +x /home/clang/build_clang.sh
ENV PATH="/usr/lib/ninja-build/bin:${PATH}"

USER clang
WORKDIR /home/clang
RUN ./build_clang.sh
