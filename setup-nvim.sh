#!/bin/bash
set -euo pipefail

# VARIABLES
TARGET_USER="coco"
NVIM_SRC_DIR="/tmp/neovim-src"

# ensure sudo is installed and user has sudo group
apt update
apt install -y sudo
/usr/sbin/usermod -aG sudo "$TARGET_USER"

# function to install neovim + LazyVim for a given user
install_for_user() {
  local USERNAME="$1"
  local USER_HOME
  USER_HOME="$(eval echo ~"$USERNAME")"
  local CONFIG_DIR="$USER_HOME/.config/nvim"
  local TEMP_REPO="/tmp/custom-nvim-config"

  # packages required for building Neovim
  apt install -y ninja-build gettext cmake unzip curl

  # build Neovim
  rm -rf "$NVIM_SRC_DIR"
  git clone https://github.com/neovim/neovim.git "$NVIM_SRC_DIR"
  cd "$NVIM_SRC_DIR"
  make CMAKE_BUILD_TYPE=Release
  make install
  cd /
  rm -rf "$NVIM_SRC_DIR"

  # install LazyVim config for this user
  sudo -u "$USERNAME" git clone https://github.com/LazyVim/starter "$CONFIG_DIR"
  sudo -u "$USERNAME" rm -rf "$CONFIG_DIR/.git"

  # clone your custom config repo
  rm -rf "$TEMP_REPO"
  git clone "$CUSTOM_REPO" "$TEMP_REPO"

  # replace config and plugins folders
  sudo -u "$USERNAME" rm -rf "$CONFIG_DIR/lua/config" "$CONFIG_DIR/lua/plugins"
  sudo -u "$USERNAME" cp -r "$TEMP_REPO/config" "$TEMP_REPO/plugins" "$CONFIG_DIR/lua/"

  rm -rf "$TEMP_REPO"

  echo "Custom LazyVim config applied for $USERNAME."
}

# install once as user 'coco'
install_for_user "$TARGET_USER"

# install once for root
install_for_user "root"

echo "Done."
