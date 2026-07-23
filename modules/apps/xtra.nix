{ self, inputs, ... }:
{
  flake.homeModules.xtra = { pkgs, lib, config, ... }:
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
  };
}
