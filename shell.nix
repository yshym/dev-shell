{ pkgs ? import (fetchTarball
  "https://github.com/yevhenshymotiuk/nixpkgs/archive/master.tar.gz") { } }:

with pkgs;
mkShell {
  buildInputs = [ cowsay ];

  shellHook = ''
    echo "Hi. Welcome to the dev shell!"
  '';
}
