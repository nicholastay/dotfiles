{ pkgs, lib, ... }:
let
  isDarwin = pkgs.stdenv.isDarwin;
in
{
  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "26.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    neovim

    ripgrep
    moreutils
    jq
    fzf
    tree
    fd

    atuin
    zsh-autosuggestions
    zsh-syntax-highlighting

    imagemagick
    gifsicle
    toilet

    subversion

    yq-go
    ripgrep-all
    colordiff
    diffutils
    wdiff
    dos2unix
    qrencode

    go

    cmatrix

    # TODO: My very own 'passgen' !
  ];

  # macOS DefaultKeyBinding - uncook home/end to be like Win start/end-line
  home.file."Library/KeyBindings/DefaultKeyBinding.dict" = lib.mkIf pkgs.stdenv.isDarwin {
    source = ../files/darwin/DefaultKeyBinding.dict;
  };

  # TODO: hack for zsh plugins to work before migrating rc into home-manager
  #       REMOVE upon HM
  home.file = {
    ".local/nix/zsh-autosuggestions".source = "${pkgs.zsh-autosuggestions}";
    ".local/nix/zsh-syntax-highlighting".source = "${pkgs.zsh-syntax-highlighting}";
  };
}
