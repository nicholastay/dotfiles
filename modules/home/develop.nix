{ pkgs, config, lib, ... }:
{
  home.packages = with pkgs; [
    fzf
    fd

    atuin
    zsh-autosuggestions
    zsh-syntax-highlighting

    # TODO: My very own 'passgen' !
  ];

  home.shellAliases = {
    vi = "nvim";
    vim = "nvim";
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    dotDir = "${config.xdg.configHome}/zsh";

    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    initContent = ''
      PROMPT="%F{006}%n%f%F{243}@%f%F{013}%m%f%F{243}:%f%(5~|%-1~/…/%3~|%4~)%f » "
      # ... SSH prefix.
      [ ! -z $SSH_CLIENT ] && PROMPT="(SSH) $PROMPT"
    '';
  };
  programs.atuin = {
    enable = true;
    flags = [ "--disable-up-arrow" ];
    settings = {
      auto_sync = false;
      search_mode = "fulltext";
      show_tabs = false;
      show_help = false;
      invert = true;
      inline_height = 16;
      style = "compact";
      dialect = "uk";
      ctrl_n_shortcuts = true;
    };
  };
  programs.fzf = {
    defaultOptions = [ "--layout=reverse" "--height=85%" ];
    enableZshIntegration = true;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
}
