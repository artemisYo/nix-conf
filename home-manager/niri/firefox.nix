{ pkgs, config, lib, ... }: let
  cfg = config.custom.firefox;
in {
  options.custom.firefox = {
    enable = lib.mkEnableOption "not even a firefox config";
    isDefault = lib.mkEnableOption "whether to use as default browser";
  };
  options.custom.browser = lib.mkOption { type = lib.types.str; default = "firefox"; };
  config = lib.mkIf cfg.enable {
    custom.browser = lib.mkIf cfg.isDefault "firefox";
    home.packages = [ pkgs.firefox ];
  };
}
