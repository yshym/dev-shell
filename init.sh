#!/usr/bin/env bash

# install nix
if ! command -v nix &> /dev/null; then
    sh <(curl -Ls https://nixos.org/nix/install)
    source ~/.nix-profile/etc/profile.d/nix.sh
fi

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
