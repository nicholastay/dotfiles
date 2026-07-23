{
  description = "ntay's nix setup";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-26.05-darwin";

    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";

    import-tree.url = "github:denful/import-tree";
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake
    { inherit inputs; } 
    {
      imports = [
        (inputs.import-tree ./modules)
        
	# TODO: ? - is this how you are meant to do it so it's mergeable like darwin/nixos?
	(
	  { lib, ...}:
	  {
	    options.flake.homeModules = lib.mkOption {
	      type = lib.types.lazyAttrsOf lib.types.raw;
	      default = { };
	    };
	  }
	)
      ];
      systems = [ "x86_64-linux" "aarch64-darwin" ];
      perSystem = { config, pkgs, ... }: {
        packages.passgen = pkgs.callPackage ./pkgs/passgen/package.nix { };
      };
    };
}
