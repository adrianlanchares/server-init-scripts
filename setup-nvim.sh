#!/bin/bash
set -euo pipefail

# VARIABLES
TARGET_USER="coco"
NVIM_SRC_DIR="/tmp/neovim-src"

# ensure sudo is installed and user has sudo group
apt update
apt install -y sudo
usermod -aG sudo "$TARGET_USER"

# function to install neovim + LazyVim for a given user
install_for_user() {
  local USERNAME="$1"
  local USER_HOME
  USER_HOME="$(eval echo ~"$USERNAME")"

  # packages required for building Neovim
  apt install -y ninja-build gettext cmake unzip curl git

  # build Neovim
  rm -rf "$NVIM_SRC_DIR"
  git clone https://github.com/neovim/neovim.git "$NVIM_SRC_DIR"
  cd "$NVIM_SRC_DIR"
  make CMAKE_BUILD_TYPE=Release
  make install
  cd /
  rm -rf "$NVIM_SRC_DIR"

  # install LazyVim config for this user
  sudo -u "$USERNAME" git clone https://github.com/LazyVim/starter "$USER_HOME/.config/nvim"
  sudo -u "$USERNAME" rm -rf "$USER_HOME/.config/nvim/.git"
}

# install once as user 'coco'
install_for_user "$TARGET_USER"

# install once for root
install_for_user "root"

echo "Done."
