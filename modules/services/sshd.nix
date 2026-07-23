{ self, inputs, ... }:
{
  flake.nixosModules.sshd = { pkgs, lib, config, ... }:
  {
    services.openssh = {
      enable = true;
      openFirewall = true;
      settings = {
        PermitRootLogin = "no";
      };
    };
  };
}
