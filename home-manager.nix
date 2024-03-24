{ pkgs, ... }: {
  imports = 
    [ ./niri.nix 
      ./emacs.nix
      ./nushell.nix
    ];
  custom.niri.wallpaperPath = let 
    wallpapers = import ./wallpapers.nix; 
  in wallpapers.topDownBuilding;

  custom.niri.enable = true;
  custom.foot.enable = true;
  custom.kitty.enable = false;
  custom.firefox.enable = true;
  custom.swaylock.enable = true;
  custom.niri.editorExec = [ "emacs" ];
  custom.niri.keyboardVariant = "workman";
  custom.ironbar.enable = true;
  
  custom.nushell.enable = true;

  home.packages = with pkgs; [
    git # nixos-rebuild shits itself otherwise
  ];
  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}
