# Setup Neovim
FROM quay.io/toolbx-images/alpine-toolbox:edge as neovim-builder
COPY scripts /scripts
RUN ./scripts/install-neovim.sh

# Setup Orora-CLI
ARG USER="${USER:-hikaru}"
FROM ghcr.io/ublue-os/bluefin-cli:latest as orora-cli

# ARG USER
LABEL com.github.containers.toolbox="true" \
    usage="This image is meant to be used with the toolbox or distrobox command" \
    summary="A cloud-native terminal experience" \
    maintainer="lecoqjacob@gmail.com"

COPY files /
COPY extra-packages /

RUN apk update && \
    apk upgrade && \
    grep -v '^#' /extra-packages | xargs apk add

# Copy over the neovim binary
COPY --from=neovim-builder /neovim/build/bin/nvim /usr/local/bin/nvim

# Install chezmoi and initialize it
RUN sh -c "$(curl -fsLS get.chezmoi.io)" && \
    chezmoi init https://github.com/bayou-brogrammer/dots.git -S "/var/home/${USER}/.local/share/chezmoi" -D "/var/home/${USER}"

# Clean up
RUN rm /extra-packages

