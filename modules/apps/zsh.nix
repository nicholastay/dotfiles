{ self, inputs, ... }:
{
  flake.homeModules.zsh = { pkgs, lib, config, ... }:
  {
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
  };
}
