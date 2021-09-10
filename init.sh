#!/usr/bin/env bash

# install nix or source shell environment
NIX_SH_FILE="$HOME/.nix-profile/etc/profile.d/nix.sh"
NIX_EXISTS=1
if [[ ! -e "$NIX_SH_FILE" ]]; then
    NIX_EXISTS=0
    sh <(curl -Ls https://nixos.org/nix/install)
fi
source "$NIX_SH_FILE"
! command nix flake --version &> /dev/null && nix-env -iA nixpkgs.nixFlakes

# explicitly enable flakes
NIX_CONF_FILE="$HOME/.config/nix/nix.conf"
if [[ ! -e "$NIX_CONF_FILE" ]]; then
    mkdir -p "$HOME/.config/nix"
    touch "$NIX_CONF_FILE"
fi
echo "experimental-features = nix-command flakes" > "$NIX_CONF_FILE"

# start dev shell
nix develop github:yevhenshymotiuk/dev-shell

# remove nix if existed
test $NIX_EXISTS -eq 0 \
    && rm -rf \
        /etc/profile/nix.sh \
        /etc/nix \
        /nix ~root/.nix-profile \
        ~root/.nix-defexpr \
        ~root/.nix-channels \
        ~/.nix-profile \
        ~/.nix-defexpr \
        ~/.nix-channels \
