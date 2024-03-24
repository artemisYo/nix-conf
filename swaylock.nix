{ pkgs, config, lib, ... }: let
  cfg = config.custom.swaylock;
in {
  options.custom.swaylock.enable = lib.mkEnableOption "custom swaylock config";
  
  config = lib.mkIf cfg.enable {
    programs.swaylock.enable = true;
    programs.swaylock.settings = {
      # image = "something.jpg";
      show-keyboard-layout = true;
      scaling = "fill";
    };
  };
}
