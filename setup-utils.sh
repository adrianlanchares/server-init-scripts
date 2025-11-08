#!/bin/bash

# Install zoxide
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

echo "alias z='zoxide'" >>~/.bashrc

# Install fzf
sudo apt install fzf

# Install lazygit
sudo apt install lazygit
echo "alias lzg='lazygit'" >>~/.bashrc

# Install lazydocker
sudo apt install lazydocker
echo "alias lzd='lazydocker'" >>~/.bashrc
