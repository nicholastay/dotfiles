{ pkgs, config, lib, ... }:
{
  imports = [
    ./atuin.nix
  ];

  home.packages = with pkgs; [
    zsh-autosuggestions
    zsh-syntax-highlighting
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;

    dotDir = "${config.xdg.configHome}/zsh";
    defaultKeymap = "viins";

    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    initContent = ''
      source ${../../files/zsh/basic.zsh}
    '';
  };

  programs.atuin.enable = lib.mkDefault true;
}
