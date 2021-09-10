#!/usr/bin/env bash

# install nix or source shell environment
NIX_SH_FILE="$HOME/.nix-profile/etc/profile.d/nix.sh"
if [[ ! -e "$NIX_SH_FILE" ]]; then
    sh <(curl -Ls https://nixos.org/nix/install)
fi
source "$NIX_SH_FILE"

# process substitution can not be used to start nix shell
# because of https://github.com/NixOS/nix/issues/2734, so
# temporary file should be created to store content of the
# shell.nix file
TEMP_SHELL_FILE="$(mktemp)"
# download content of the shell file
curl -Ls https://github.com/yevhenshymotiuk/dev-shell/raw/master/shell.nix \
    > "$TEMP_SHELL_FILE"
# start shell
nix-shell "$TEMP_SHELL_FILE"
# remove temporary shell file
rm "$TEMP_SHELL_FILE"
