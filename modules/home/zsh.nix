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
      PROMPT="%F{006}%n%f%F{243}@%f%F{013}%m%f%F{243}:%f%(5~|%-1~/…/%3~|%4~)%f » "
      # ... SSH prefix.
      [ ! -z $SSH_CLIENT ] && PROMPT="(SSH) $PROMPT"

      bindkey '^K' autosuggest-execute
    '';
  };

  programs.atuin.enable = lib.mkDefault true;
}
