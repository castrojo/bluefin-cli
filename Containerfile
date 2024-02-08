FROM ghcr.io/ublue-os/wolfi-toolbox:latest

LABEL com.github.containers.toolbox="true" \
      usage="This image is meant to be used with the toolbox or distrobox command" \
      summary="A cloud-native terminal experience" \
      maintainer="jorge.castro@gmail.com"

COPY extra-packages /
RUN apk update && \
    apk upgrade && \
    #grep -v '^#' /extra-packages | xargs apk add
RUN apk add atuin
RUN apk add brew
RUN apk add gawk
RUN apk add eza
RUN apk add fd
RUN apk add fish
RUN apk add fzf
RUN apk add ripgrep
RUN apk add sed
RUN apk add starship
RUN apk add sudo-rs
RUN apk add zoxide
RUN apk add direnv
RUN apk add gh
RUN apk add helix
RUN apk add lazygit
RUN apk add neovim
RUN apk add ollama
RUN apk add py3-pip
RUN apk add ssh-import-id
RUN apk add vim
RUN apk add zellij

RUN rm /extra-packages
     
