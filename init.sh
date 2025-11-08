#!/bin/bash

# Scripts to initialize homelab server and install essential utilities
# cocoloco

# set up ghostty terminal
./setup-ghostty.sh

# install nvim
./setup-nvim.sh

# set up starship
./setup-starship.sh

# change lid closing behavior
./setup-lid-close.sh

# install docker
./setup-docker.sh

# install and run tailscale
./setup-tailscale.sh
