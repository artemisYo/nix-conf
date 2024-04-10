{
  description = "My NixOs config idk...";

  inputs = {
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-unstable";

    home-manager.url = "./home-manager/";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, home-manager, ... }: {
    nixosConfigurations = {
      absinth = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          # load configs, configuration.nix should be user-provided
          /etc/nixos/configuration.nix
          # enable power management utils
          ./power.nix
          # periodically run gc
          ./autogc.nix
          # display manager fuckery
          ./dm.nix
          # enable flakes
          { nix.settings.experimental-features = [ "nix-command" "flakes" ]; }
          # enable niri and home manager
          home-manager.nixosModules.home-manager
          home-manager.nixosModules.niri
          {
            programs.niri.enable = true;
          }
          # enable home-manager config
          {
            home-manager.useGlobalPkgs = true;
            home-manager.users.artemis = home-manager.nixosModules.default;
          }
        ];
      };
    };
  };
}
