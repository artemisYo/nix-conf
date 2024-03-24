{ pkgs, config, lib, ... }: let
  cfg = config.custom.nushell;
in {
  options.custom.nushell = with lib; {
    enable = mkEnableOption "custom nushell config";
  };

  config = lib.mkIf cfg.enable {
    programs.nushell.enable = true;
  };
}
