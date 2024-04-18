{
  description = "Custom wofi config";

  inputs = {
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-unstable";
    
    wofi-pm.url = "github:szaffarano/wofi-power-menu";
    wofi-pm.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, wofi-pm, ... }: {
    nixosModules.default = { config, lib, ... }: let
      cfg = config.custom.wofi;
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        overlays = [ (final: prev: { wofi-pm = wofi-pm.defaultPackage.x86_64-linux; }) ];
      };
    in {
      config = {
        programs.wofi.enable = true;
        home.packages = [ pkgs.wofi-pm ];
      };
    };
  };
}
