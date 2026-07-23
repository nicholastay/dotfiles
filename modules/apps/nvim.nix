{ self, inputs, ... }:
{
  flake.homeModules.nvim = { pkgs, lib, config, ... }:
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
  };
}
