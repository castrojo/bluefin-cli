#!/usr/bin/env bash

set -ouex pipefail

# This script will clone neovim and build it from source
git clone https://github.com/neovim/neovim.git
cd neovim

# Install dependencies
sudo apk add build-base cmake coreutils curl unzip gettext-tiny-dev

# Build neovim
make CMAKE_BUILD_TYPE=RelWithDebInfo

# Install neovim
sudo make install

# Check the version
./build/bin/nvim --version | grep ^Build
