{ pkgs }:

let
  config = builtins.fetchTarball {
    url =
      "https://github.com/yevhenshymotiuk/nix-config/archive/f2b7f22991b898766aa3d804123e118acc0a7d70.tar.gz";
    sha256 = "1lfai35j2k1v1vfnpvwl94m8rdmq34zkbvshfvkwmq079hg9031m";
  };
  vimConfig = (import "${config}/home/programs/vim.nix" { inherit pkgs; config={}; }).programs.vim;
  myVim = pkgs.vim_configurable.customize {
    name = "vim";
    vimrcConfig = {
      packages.myVimPackage.start = vimConfig.plugins;
      customRC = vimConfig.extraConfig;
    };
  };
in with pkgs;
mkShell {
  buildInputs = [ bat exa gdb myVim ripgrep ];

  shellHook = ''
    alias cat="bat --style plain"
    alias grep="rg"
    alias ls="exa --group-directories-first"
  '';
}
