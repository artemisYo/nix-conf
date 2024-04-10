{ pkgs, config, lib, ... }: let
  cfg = config.custom.kitty;
in {
  options.custom.kitty = with lib; {
    enable = mkEnableOption "custom kitty config";
    font = {
      package = mkPackageOption pkgs "fira-code" {};
      name = mkOption {
        type = types.str; 
        default = "Fira Code"; 
      };
      size = mkOption {
        type = types.ints.unsigned;
        default = 14;
      };
    };
  };

  config = lib.mkIf cfg.enable {
    custom.niri.termExec = [ "kitty" ];
    programs.kitty.enable = true;
    programs.kitty = {
      font.name = cfg.font.name;
      font.package = cfg.font.package;
      font.size = cfg.font.size;
      theme = "Everforest Dark Medium";
    };
  };
}
