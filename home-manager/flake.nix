{
  description = "Custom home manager config as a flake";

  inputs = {
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    niri.url = "./niri/";
    niri.inputs.nixpkgs.follows = "nixpkgs";

    wallpapers.url = "./wallpapers/";
  };

  outputs = { nixpkgs, home-manager, niri, wallpapers, ... }: {
    nixosModules.home-manager = home-manager.nixosModules.home-manager;
    nixosModules.niri = niri.nixosModules.niri;
    nixosModules.default = { pkgs, ... }: {
      imports =
        [ ./emacs.nix
          ./nushell.nix
          niri.nixosModules.default
          wallpapers.nixosModules.default
        ];
      
      custom.niri.enable = true;
      # custom.foot.enable = true;
      custom.kitty.enable = true;
      custom.dunst.enable = true;
      custom.firefox.enable = true;
      custom.swaylock.enable = true;
      custom.niri.editorExec = [ "emacs" ];
      custom.niri.keyboardVariant = "";
      # custom.ironbar.enable = true;
      custom.yambar.enable = true;
      custom.eww.enable = true;

      home.packages = with pkgs; [
        git # nixos-rebuild shits itself otherwise
        libqalculate
      ];
      home.stateVersion = "23.11";
      programs.home-manager.enable = true;
    };
  };
}
