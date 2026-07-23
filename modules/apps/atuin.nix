{ self, inputs, ... }:
{
  flake.homeModules.atuin = { pkgs, lib, config, ... }:
  {
    programs.atuin.flags = [ "--disable-up-arrow" ];
    programs.atuin.settings = {
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
}
