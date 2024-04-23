{ pkgs, config, lib, ... }: let
  cfg = config.custom.rofi;
in {
  options.custom.rofi = with lib; {
    enable = mkEnableOption "custom rofi config";
    wayland = mkOption {
      type = types.bool;
      default = true;
    };
  };
  config = lib.mkIf cfg.enable {
    programs.rofi.enable = true;
    programs.rofi.package = lib.mkIf cfg.wayland pkgs.rofi-wayland;
  };
}
