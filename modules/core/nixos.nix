{ self, inputs, ... }:
{
  flake.nixosModules.core = { pkgs, ... }: {
    imports = [ ./_common.nix ];

    # List packages installed in system profile. To search by name, run:
    # $ nix-env -qaP | grep wget
    environment.systemPackages = with pkgs; [
      vim
      git
      curl
      ncdu
    ];

    networking.firewall.enable = true;
  };
}
