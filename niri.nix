{ pkgs, config, lib, ... }: let
  cfg = config.custom.niri;
in {
  imports = 
    [ ./foot.nix
      ./kitty.nix
      ./swaylock.nix
      ./firefox.nix
      ./dunst.nix
      ./ironbar.nix
    ];
  options.custom.niri = with lib; {
    enable = mkEnableOption "custom niri config";
    termExec = mkOption { 
      type = types.listOf types.str; 
    };
    editorExec = mkOption { 
      type = types.listOf types.str; 
    };
    browserExec = mkOption {
      type = types.listOf types.str; 
    };
    keyboardVariant = mkOption {
      type = types.str;
      default = "workman";
    };
    wallpaperPath = mkOption {
      type = types.path;
    };
  };
  config = lib.mkIf cfg.enable {
    # enable wofi
    programs.wofi.enable = true;  

    home.packages =
    [ pkgs.swaybg 
      pkgs.brightnessctl 
    ];

    programs.niri.settings = {
      hotkey-overlay.skip-at-startup = true;
      binds = with config.lib.niri.actions; {
        "Mod+D".spawn = [ "wofi" "--show" "run" ];
        "Mod+P".spawn = [ "swaylock" ];
        "Mod+T".spawn = cfg.termExec;
        "Mod+E".spawn = cfg.editorExec;
        "Mod+B".spawn = cfg.browserExec;
        "Mod+Shift+Equal".set-column-width = "+10%";
        "Mod+Minus".set-column-width = "-10%";
        "XF86MonBrightnessUp".spawn = [ "brightnessctl" "set" "15%+" ];
        "XF86MonBrightnessDown".spawn = [ "brightnessctl" "set" "15%-" ];
        "Mod+Q" = close-window;
        "Mod+H" = focus-column-right;
        "Mod+Shift+H" = move-column-right;
        "Mod+J" = focus-window-down;
        "Mod+Shift+J" = move-window-down;
        "Mod+K" = focus-window-up;
        "Mod+Shift+K" = move-window-up;
        "Mod+L" = focus-column-left;
        "Mod+Shift+L" = move-column-left;
        # "Mod+1".focus-workspace = 1;
        # "Mod+2".focus-workspace = 2;
        # "Mod+3".focus-workspace = 3;
        # "Mod+4".focus-workspace = 4;
        # "Mod+5".focus-workspace = 5;
        # "Mod+6".focus-workspace = 6;
        # "Mod+7".focus-workspace = 7;
        # "Mod+8".focus-workspace = 8;
        # "Mod+9".focus-workspace = 9;
      };
      screenshot-path = "~/Pictures/Screenshots/";
      spawn-at-startup = 
        [{ command = [ "swaybg" "-m" "fill" "-i" cfg.wallpaperPath ]; }];
      input.keyboard = {
        track-layout = "global";
        xkb.layout = "us";
        xkb.variant = cfg.keyboardVariant;
      };
      input.mouse.natural-scroll = false; # natural-scroll :barf:
      input.touchpad.natural-scroll = false;
      input.touchpad.tap = true;
      input.touchpad.tap-button-map = "left-right-middle";

      # layout.border = {
      #   enable = true;
      #   width = 2;
      #   active.color = "rgb(255, 255, 255)";
      #   inactive.color = "rgb(80, 80, 80)";
      # };
      layout.focus-ring = {
        width = 2;
        active.color = "#fecdb2";
        inactive.color = "#6f5d63";
      };
      layout.center-focused-column = "on-overflow";
      layout.default-column-width.proportion = 0.5;
    };
  };
}
