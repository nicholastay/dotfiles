{ self, inputs, lib, ... }:
let
  hmSystemConfig = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    useUserPackages = true;
  };
in
{
  # For home-manager stuffs, cross platforms.
  flake.homeModules.base = { pkgs, lib, config, ... }:
  {
    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

    home.packages = with pkgs; [
      ripgrep
      moreutils
      jq
      tree
    ];

    home.shellAliases = {
      g = "git";
      sudo = "sudo ";  # tab completion / alias expansion
      v = "$EDITOR";
      ag = "rg";  # muscle memory will be the death of me
      rg = "rg -S";
    };

    # macOS DefaultKeyBinding - uncook home/end to be like Win start/end-line
    home.file."Library/KeyBindings/DefaultKeyBinding.dict" = lib.mkIf pkgs.stdenv.isDarwin {
      source = ../files/darwin/DefaultKeyBinding.dict;
    };

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    home.stateVersion = "26.05";
  };

  flake.nixosModules.home = { ... }:
  {
    imports = [
      inputs.home-manager.nixosModules.home-manager
    ];
    home-manager = hmSystemConfig;
  };

  flake.darwinModules.home = { ... }:
  {
    imports = [
      inputs.home-manager.darwinModules.home-manager
    ];
    home-manager = hmSystemConfig;
  };
}
