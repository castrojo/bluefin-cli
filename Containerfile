# syntax=docker/dockerfile:1.4

FROM ghcr.io/ublue-os/bluefin-dx-cli:latest

LABEL maintainer "Hikaru"
LABEL com.github.containers.toolbox="true" \
    usage="This image is meant to be used with the toolbox or distrobox command" \
    summary="A cloud-native terminal experience" \
    maintainer="lecoqjacob@gmail.com"

COPY files /
COPY extra-packages /

RUN apk update && \
    apk upgrade && \
    grep -v '^#' /extra-packages | xargs apk add

# Install Rust and cargo binstall
RUN curl https://sh.rustup.rs -sSf | bash -s -- -y && \
    curl https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh -sSf | bash -s -- -y

ENV PATH="/root/.cargo/bin:${PATH}"

RUN cargo install sd && \
    cargo install --git https://github.com/dandavison/delta && \
    cargo install --git https://github.com/lsd-rs/lsd.git --branch master

# Change root shell to FISH
RUN sd 'root:/bin/bash' 'root:/usr/bin/fish' /etc/passwd && \
    # optional directory to mount the host's home directory
    mkdir -p /mnt/host