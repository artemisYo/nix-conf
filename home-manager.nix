{ pkgs, ... }: {  
  imports = 
    [ # ./niri.nix 
      ./emacs.nix
      ./nushell.nix
    ];
  custom.niri.wallpaperPath = let 
    wallpapers = import ./wallpapers.nix; 
  in wallpapers.cabin;

  custom.niri.enable = true;
  custom.foot.enable = false;
  custom.kitty.enable = true;
  custom.dunst.enable = true;
  custom.firefox.enable = true;
  custom.swaylock.enable = true;
  custom.niri.editorExec = [ "emacs" ];
  custom.niri.keyboardVariant = "";
  custom.ironbar.enable = true;
  custom.eww.enable = true;

  home.packages = with pkgs; [
    git # nixos-rebuild shits itself otherwise
    libqalculate
  ];
  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}
