{ pkgs, config, lib, ... }: let
  cfg = config.custom.foot;
in {
  options.custom.foot = with lib; {
    enable = mkEnableOption "foot terminal config";
    fontsize = mkOption {
      type = types.str;
      default = "14";
    };
  };

  config = lib.mkIf cfg.enable {
    custom.niri.termExec = [ "foot" ];
    programs.foot.enable = true;
    programs.foot.settings.main.font = pkgs.lib.strings.concatStrings
      [ "Fira Code"
        ":size=" cfg.fontsize
        ":fontfeatures=ss03"
        ":fontfeatures=ss09"
        ":fontfeatures=cv16"
        ":fontfeatures=cv29"
      ];
    fonts.fontconfig.enable = true;
    home.packages = [ pkgs.fira-code ];
  };
}
