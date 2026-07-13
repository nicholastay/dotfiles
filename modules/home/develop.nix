{ pkgs, config, lib, ... }:
let
  passgen = pkgs.callPackage ../../pkgs/passgen/package.nix { };
in
{
  imports = [
    ./zsh.nix
    ./git.nix
    ./nvim.nix
  ];

  home.packages = with pkgs; [
    fzf
    fd

    passgen
  ];

  programs.fzf = {
    defaultOptions = [ "--layout=reverse" "--height=85%" ];
    enableZshIntegration = true;
  };
}
