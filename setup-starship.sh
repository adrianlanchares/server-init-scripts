curl -sS https://starship.rs/install.sh | sh

echo 'eval "$(starship init bash)"' >>~/.bashrc

cp starship.toml ~/.config/starship.toml
