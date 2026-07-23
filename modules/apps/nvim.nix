{ self, inputs, ... }:
{
  flake.homeModules.nvim = { pkgs, lib, config, ... }:
  {
    imports = [ inputs.nvf.homeManagerModules.default ];

    programs.nvf = {
      enable = true;

      defaultEditor = true;

      settings.vim = {
        viAlias = true;
        vimAlias = true;

        binds.whichKey.enable = true;

        lsp.enable = true;
        treesitter.enable = true;

        languages.nix.enable = true;
      };
    };
  };
}
