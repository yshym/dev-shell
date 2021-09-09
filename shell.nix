{ pkgs ? import (fetchTarball
  "https://github.com/yevhenshymotiuk/nixpkgs/archive/nixpkgs-unstable.tar.gz")
  { } }:

with pkgs;
mkShell {
  buildInputs = [ bat exa ripgrep ];

  shellHook = ''
    alias cat="bat --style plain"
    alias grep="rg"
    alias ls="exa --group-directories-first"
  '';
}
