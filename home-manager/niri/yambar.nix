{ pkgs, config, lib, ... }: let
  cfg = config.custom.yambar;
in {
  options.custom.yambar = with lib; {
    enable = mkEnableOption "custom yambar config";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ pkgs.yambar ];
    home.file.".config/yambar/config.yml".text = ''
      bar:
        height: 20
        location: bottom
        font: Fira Code
        foreground: ffffffff
        background: 000000ff

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