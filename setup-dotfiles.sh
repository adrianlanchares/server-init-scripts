#!/bin/zsh

sudo apt install stow -y

git clone https://github.com/adrianlanchares/dotfiles ~/dotfiles

cd dotfiles

for pkg in "${PACKAGES[@]}"; do
    stow -R "$pkg"
done

echo "Dotfiles stowed."

