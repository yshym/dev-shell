{ pkgs }:

let
  config = builtins.fetchTarball {
    url = "https://github.com/yevhenshymotiuk/nix-config/archive/master.tar.gz";
    sha256 = "0bs8g7ihj75jn0biay9bcsmb1wsby8cmifhpwm41laxykc5qczp8";
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
