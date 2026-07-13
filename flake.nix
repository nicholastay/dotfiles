{
  description = "ntay's nix setup";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-26.05-darwin";

    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, nix-darwin, home-manager }:
  let
    darwinBase = import ./modules/darwin/base.nix;
    homeBase   = import ./modules/home/base.nix;
    nixosBase  = import ./modules/nixos/base.nix;

    mkDarwin = { user, self, homePath ? "/Users/${user}", modules ? [], homeModules ? [] }:
      nix-darwin.lib.darwinSystem {
        specialArgs = { inherit self user homePath; };
        modules = [
          darwinBase
          home-manager.darwinModules.home-manager {
            # user already exists -> but to tell what the homedir is
            # via mitchellh config: https://github.com/nix-darwin/nix-darwin/issues/423
            users.users.${user}.home = homePath;

            home-manager.useGlobalPkgs    = true;
            home-manager.useUserPackages  = true;
            home-manager.extraSpecialArgs = { inherit user homePath; };
            home-manager.users.${user}.imports = [ homeBase ] ++ homeModules;
          }
        ] ++ modules;
      };

    mkNixos = { user, self, hostName, homePath ? "/home/${user}", modules ? [], homeModules ? [] }:
      nixpkgs.lib.nixosSystem {
        specialArgs = { inherit self user homePath hostName; };
        modules = [
          nixosBase
          ./hosts/${hostName}/configuration.nix
          ./hosts/${hostName}/hardware-configuration.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs    = true;
            home-manager.useUserPackages  = true;
            home-manager.extraSpecialArgs = { inherit user homePath; };
            home-manager.users.${user}.imports = [ homeBase ] ++ homeModules;
          }
        ] ++ modules;
      };

    mkHome = { user, system ? "x86_64-linux", homePath ? "/home/${user}", modules ? [] }:
      home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        extraSpecialArgs = { inherit user homePath; };
        modules = [
          homeBase
          {
            home.username      = user;
            home.homeDirectory = homePath;
          }
        ] ++ modules;
      };
  in
  {
    darwinModules.base = darwinBase;
    homeModules.base   = homeBase;
    nixosModules.base  = nixosBase;
    lib.mkDarwin       = mkDarwin;
    lib.mkHome         = mkHome;
    lib.mkNixos        = mkNixos;


    # System + home, integrated (one rebuild):
    # --- Darwin ---
    # $ darwin-rebuild switch --flake .#mac-base
    darwinConfigurations."mac-base" = mkDarwin { user = "nick"; inherit self; };

    # --- NixOS ---
    # $ nixos-rebuild switch --flake .#lumine
    nixosConfigurations."lumine" = mkNixos {
      # sandbox VM
      inherit self;
      hostName = "lumine";
      user = "nick";
      modules = [
        ./modules/nixos/sshd.nix
      ];
    };


    # Home only, standalone (no nix-darwin):
    # $ home-manager switch --flake .#nick@home-base
    homeConfigurations."nick@home-base" = mkHome { user = "nick"; inherit self; };
  };
}
