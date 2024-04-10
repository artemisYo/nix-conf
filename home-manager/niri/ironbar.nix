{ pkgs, config, lib, ... }: let
  cfg = config.custom.ironbar;
in {
  options.custom.ironbar = with lib; {
    enable = mkEnableOption "custom ironbar config";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.ironbar ];
    home.file.".config/ironbar/config.toml".text = ''
      anchor_to_edges = true
      position = "top"
      [[center]]
      type = "clock"
      [[end]]
      type = "upower"
    '';
  };
}
