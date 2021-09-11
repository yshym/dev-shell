#!/usr/bin/env bash

# install nix if not exists
NIX_PROFILE_DIR="$HOME/.nix-profile"
NIX_SH_FILE="$NIX_PROFILE_DIR/etc/profile.d/nix.sh"
NIX_EXISTS=1
if [[ ! -e "$NIX_PROFILE_DIR" ]]; then
    NIX_EXISTS=0
    sh <(curl -Ls https://nixos.org/nix/install)
fi
test -e "$NIX_SH_FILE" && source "$NIX_SH_FILE"

# replace stable version of nix with nix flakes if not exists
NIX_FLAKES_EXISTS=1
if ! command nix flake --version &> /dev/null; then
    NIX_FLAKES_EXISTS=0
    nix-env -iA nixpkgs.nixFlakes
fi

# explicitly enable flakes
NIX_CONF_FILE="$HOME/.config/nix/nix.conf"
if [[ ! -e "$NIX_CONF_FILE" ]]; then
    mkdir -p "$HOME/.config/nix"
    touch "$NIX_CONF_FILE"
fi
echo "experimental-features = nix-command flakes" > "$NIX_CONF_FILE"

# install cachix if not exists
if ! command cachix --version &> /dev/null; then
    nix-env -iA nixpkgs.cachix
    cachix use yevhenshymotiuk
fi

# start dev shell
nix develop github:yevhenshymotiuk/dev-shell

# replace flakes back if the stable version of nix was installed
test $NIX_EXISTS -eq 1 && test $NIX_FLAKES_EXISTS -eq 0 \
    && nix-env -iA nixpkgs.nix \
    && sed -i "" -e "experimental-features = nix-command flakes" "$HOME/.config/nix"

# remove nix if not existed
test $NIX_EXISTS -eq 0 \
    && sudo rm -rf \
        /etc/profile/nix.sh \
        /etc/nix \
        /nix \
        ~/.nix-profile \
        ~/.nix-defexpr \
        ~/.nix-channels \
        ~/.config/nix
