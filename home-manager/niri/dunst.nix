{ pkgs, config, lib, ... }: let
  cfg = config.custom.dunst;
in {
  options.custom.dunst.enable = lib.mkEnableOption "dunst custom config";
  config = lib.mkIf cfg.enable {
    # enable dunst
    services.dunst.enable = true;
    services.dunst.settings.global = {
      frame-color = "#a7c080";
      background = "#232a2e";
      foreground = "#d3c6aa";
      highlight = "#a7c080"; # progress bars apparently
    };
    programs.niri.settings.spawn-at-startup = 
      [{ command = [ "dunst" ]; }];
  };
}
