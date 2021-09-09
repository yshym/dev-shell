#!/usr/bin/env bash

# install nix
if ! command -v nix &> /dev/null; then
    sh <(curl -Ls https://nixos.org/nix/install) --daemon
    nix-env -iA nixpkgs.nixFlakes
fi

# explicitly enable flakes
NIX_CONF=~/.config/nix/nix.conf
if [[ ! -e "$NIX_CONF" ]]; then
    mkdir -p ~/.config/nix
    touch ~/.config/nix/nix.conf
fi
echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf

# download shell file
curl -Ls https://github.com/yevhenshymotiuk/dev-shell/raw/master/shell.nix > shell.nix
# start shell
nix-shell
