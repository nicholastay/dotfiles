{ pkgs, config, lib, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  home.shellAliases = {
    vi = "nvim";
    vim = "nvim";
  };

  # TODO: choose how to link in lua config
}
