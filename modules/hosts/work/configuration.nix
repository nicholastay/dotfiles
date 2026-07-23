{ self, inputs, ... }:
{
  flake.darwinConfigurations.work = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.darwinModules; [
      hostLumine
    ];
  };

  flake.darwinModules.hostWork = { ... }: {
    imports = with self.darwinModules; [
      core
      home
    ];

    # Set Git commit hash for darwin-version.
    system.configurationRevision = self.rev or self.dirtyRev or null;

    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    system.stateVersion = 6;
  };
}
