{ pkgs }:

let
  config = builtins.fetchTarball {
    url =
      "https://github.com/yevhenshymotiuk/nix-config/archive/26a6aad310a8c1d63c9d8a914f389a14d67530b3.tar.gz";
    sha256 = "1wyl4i95jynkgbz9wiwh8ls5hv5165k98i1gagw0j27kfk97q1f0";
  };
  myVim = (import "${config}/home/programs/my-vim.nix" { inherit pkgs; }).pkg;
in with pkgs;
mkShell {
  buildInputs = [ bat exa gdb myVim ripgrep ];

  shellHook = ''
    alias cat="bat --style plain"
    alias grep="rg"
    alias ls="exa --group-directories-first"
  '';
}
