{ pkgs, config, lib, ... }: let
  cfg = config.custom.firefox;
in {
  options.custom.firefox.enable = lib.mkEnableOption "not even a firefox config";
  config = lib.mkIf cfg.enable {
    custom.niri.browserExec = [ "firefox" ];
    home.packages = [ pkgs.firefox ];
  };
}
