{ pkgs, config, lib, ... }: let
  cfg = config.custom.dunst;
in {
  options.custom.dunst.enable = lib.mkEnableOption "dunst custom config";
  config = lib.mkIf cfg.enable {
    # enable dunst
    services.dunst.enable = true;
    services.dunst.settings.global = {
      frame-color = "#101010";
      background = "#505050";
      foreground = "#ffffff";
      highlight = "#f0a060"; # progress bars apparently
    };
    programs.niri.settings.spawn-at-startup = 
      [{ command = [ "dunst" ]; }];
  };
}
