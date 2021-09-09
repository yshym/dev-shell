#!/usr/bin/env bash

# install nix
if ! command -v nix &> /dev/null; then
    sh <(curl -L https://nixos.org/nix/install) --daemon
    nix-env -iA nixpkgs.nixFlakes
fi

# explicitly enable flakes
NIX_CONF=~/.config/nix/nix.conf
if [[ ! -e "$NIX_CONF" ]]; then
    mkdir -p ~/.config/nix
    touch ~/.config/nix/nix.conf
fi
echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf

nix-shell https://github.com/yevhenshymotiuk/dev-shell/blob/master/shell.nix
