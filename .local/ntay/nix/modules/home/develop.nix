{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    zsh
    neovim

    fzf
    fd

    atuin
    zsh-autosuggestions
    zsh-syntax-highlighting

    imagemagick
    gifsicle
    toilet

    yq-go
    ripgrep-all
    colordiff
    diffutils
    wdiff
    dos2unix
    qrencode

    # TODO: My very own 'passgen' !
  ];

  # TODO: hack for zsh plugins to work before migrating rc into home-manager
  #       REMOVE upon HM
  home.file = {
    ".local/nix/zsh-autosuggestions".source = "${pkgs.zsh-autosuggestions}";
    ".local/nix/zsh-syntax-highlighting".source = "${pkgs.zsh-syntax-highlighting}";
  };
}
