{ pkgs, lib, config, ... }: let
  cfg = config.custom.bemenu;
in {
  options.custom.bemenu = with lib; {
    enable = mkEnableOption "Custom bemenu config";
  };
  config = lib.mkIf cfg.enable {
    programs.bemenu.enable = true;
    programs.bemenu.settings = {
      ignorecase = true;
      prompt = "run: ";
      fixed-height = true;
      center = true;
      line-height = 18;
    };
  };
}
