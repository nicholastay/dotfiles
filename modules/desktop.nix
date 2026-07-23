{ self, inputs, ... }:
{
  flake.nixosModules.desktop = { pkgs, config, ... }:
  {
    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.${config.nt.primaryUser} = {
      isNormalUser = true;
      extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
      home = "/home/${config.nt.primaryUser}";
      shell = pkgs.zsh;
    };

    programs.zsh.enable = true;
    environment.shells = with pkgs; [ zsh ];
  };
}
