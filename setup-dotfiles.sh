#!/bin/zsh

sudo apt install stow -y

cd $HOME
if [[ ! -d "dotfiles" ]]; then
    git clone https://github.com/adrianlanchares/dotfiles
    cd dotfiles
  else
    echo "Dotfiles already cloned. Pulling latest changes..."
    cd dotfiles
    git pull
  fi

stow zsh
stow nvim

echo "Dotfiles stowed."

