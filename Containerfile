FROM ghcr.io/ublue-os/bluefin-cli:latest

LABEL com.github.containers.toolbox="true" \
    usage="This image is meant to be used with the toolbox or distrobox command" \
    summary="A cloud-native terminal experience" \
    maintainer="lecoqjacob@gmail.com"

COPY files /
COPY extra-packages /

RUN apk update && \
    apk upgrade && \
    grep -v '^#' /extra-packages | xargs apk add

RUN rm /extra-packages

