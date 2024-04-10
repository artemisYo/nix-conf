{ pkgs, config, lib, ... }: let
  cfg = config.custom.ironbar;
in {
  options.custom.eww = with lib; {
    enable = mkEnableOption "custom eww config";
  };

  config = lib.mkIf cfg.enable {
    programs.eww.enable = true;
    programs.eww.configDir = ./eww;
  };
}