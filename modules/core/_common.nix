{ config, pkgs, lib, ... }:
{
  # Common nix system settings to darwin/nixos systems.

  options.nt = {
    primaryUser = lib.mkOption {
      type = lib.types.str;
      default = "nick";
    };
  };

  config = {
    fonts.packages = with pkgs; [
      fantasque-sans-mono
    ];

    time.timeZone = lib.mkDefault "Australia/Sydney";

    # Necessary for using flakes on this system.
    nix.settings.experimental-features = "nix-command flakes";

    # Auto optimise the store - default is daily in early morning
    # (since it uses launchd-style config, it will "catchup" on next wakeup if sleeping)
    # Manual: $ nix-store --optimise
    nix.optimise.automatic = true;
    # Auto cleanup the old generations - same default early morning schedule
    # Manual: $ nix-collect-garbage <options> (-d for all generations)
    nix.gc = {
      automatic = true;
      options = "--delete-older-than 21d";
    };
  };
}
