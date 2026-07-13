{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [
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
  ];
}
