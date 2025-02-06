# Use the official Alpine image as a parent image
FROM alpine:latest

RUN apk update
RUN apk add bash sudo

RUN adduser -D -s /bin/bash clang && \
        echo "clang ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

COPY build_clang.sh /home/clang/build_clang.sh
RUN chmod +x /home/clang/build_clang.sh

USER clang
WORKDIR /home/clang
RUN ./build_clang.sh
