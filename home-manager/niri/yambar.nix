{ pkgs, config, lib, ... }: let
  cfg = config.custom.yambar;
in {
  options.custom.yambar = with lib; {
    enable = mkEnableOption "custom yambar config";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.yambar ];
    programs.niri.settings.spawn-at-startup =
      [{ command = [ "yambar" ]; }
      ];
    home.file.".config/yambar/config.yml".text = ''
      bar:
        height: 20
        location: bottom
        font: Fira Code
        foreground: a7c080FF
        background: 2d353bFF

        center:
          - clock:
              time-format: "%H:%M"
              content:
                - string: {text: "{time}"}
        right:
          - backlight:
              name: intel_backlight
              content:
                - string: {text: "{percent}%"}
          - battery:
              name: BAT0
              content:
                - string: {text: "{capacity}%"}
    '';
  };
}
