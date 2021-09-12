{ pkgs }:

let
  config = builtins.fetchTarball {
    url =
      "https://github.com/yevhenshymotiuk/nix-config/archive/2a7165f62f81c59bbe46990380344d68a5b787a3.tar.gz";
    sha256 = "1fmq50k1svc36vw9imd0770q9n07k3kn6k45b339cfghwn36f1cx";
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
