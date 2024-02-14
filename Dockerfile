FROM ghcr.io/ublue-os/bluefin-cli:latest as orora-cli

LABEL maintainer "Hikaru"
LABEL com.github.containers.toolbox="true" \
    usage="This image is meant to be used with the toolbox or distrobox command" \
    summary="A cloud-native terminal experience" \
    maintainer="lecoqjacob@gmail.com"

ARG USER="${USER:-hikaru}"
ARG HOME_DIR="/var/home/${USER}"
ARG LOCAL_DIR="${HOME_DIR}/.local"
ARG LOCAL_BIN="${HOME_DIR}/.local/bin"

COPY files /
COPY extra-packages /

RUN apk update && \
    apk upgrade && \
    grep -v '^#' /extra-packages | xargs apk add

# Install chezmoi and initialize it
RUN sh -c "$(curl -fsLS get.chezmoi.io)" -- -b ${LOCAL_BIN} && \
    ${LOCAL_BIN}/chezmoi init --apply https://github.com/bayou-brogrammer/dots.git -D "${HOME_DIR}" -S "${LOCAL_DIR}/share/chezmoi"

# Clean up
RUN rm /extra-packages

