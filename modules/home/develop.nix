{ pkgs, config, lib, ... }:
{
  imports = [
    ./zsh.nix
    ./git.nix
    ./nvim.nix
  ];

  home.packages = with pkgs; [
    fzf
    fd

    # TODO: My very own 'passgen' !
  ];

  programs.fzf = {
    defaultOptions = [ "--layout=reverse" "--height=85%" ];
    enableZshIntegration = true;
  };
}
