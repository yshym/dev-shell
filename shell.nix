{ pkgs ? import (fetchTarball
  "https://github.com/yevhenshymotiuk/nixpkgs/archive/nixpkgs-unstable.tar.gz")
  { } }:

with pkgs;
mkShell {
  buildInputs = [ cowsay ];

  shellHook = ''
    echo "Hi. Welcome to the dev shell!"
  '';
}
