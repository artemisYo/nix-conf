{
  description = "My NixOs config idk...";

  inputs = {
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    niri.url = "github:sodiboo/niri-flake";
    niri.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, home-manager, niri, ... }: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          # load configs, ./configuration.nix should be user-provided
          ./configuration.nix
          # enable power management utils
          ./power.nix
          # periodically run gc
          ./autogc.nix
          # display manager fuckery
          ./dm.nix
          # enable flakes
          { nix.settings.experimental-features = [ "nix-command" "flakes" ]; }
          # enable niri
          niri.nixosModules.niri
          {
            programs.niri.enable = true;
          }
          # enable home-manager config
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.users.demo = import ./home-manager.nix;
          }
        ];
      };
    };
  };
}
