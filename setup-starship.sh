#!/bin/bash

curl -sS https://starship.rs/install.sh | sh

echo 'eval "$(starship init bash)"' >>~/.bashrc
echo 'eval "$(starship init bash)"' >>~/home/coco/.bashrc

cp starship.toml ~/.config/starship.toml
cp starship.toml /home/coco/.config/starship.toml
