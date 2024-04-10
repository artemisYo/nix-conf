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
      ./eww.nix
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
        pkgs.wofi-pm
      ];

    programs.niri.package = pkgs.niri-unstable;
    
    programs.niri.settings = {
      prefer-no-csd = true;
      hotkey-overlay.skip-at-startup = true;
      binds = with config.lib.niri.actions; {
        "Mod+space".action.spawn = [ "wofi" "--show" "run" ];
        "Mod+P".action.spawn = [ "swaylock" ];
        "Mod+Return".action.spawn = cfg.termExec;
        "Mod+E".action.spawn = cfg.editorExec;
        "Mod+B".action.spawn = cfg.browserExec;
        "Mod+X".action.spawn = [ "wofi-power-menu" ];
        "Mod+Shift+TouchpadScrollRight".action.set-column-width = "+1%";
        "Mod+Shift+TouchpadScrollLeft".action.set-column-width = "-1%";
        "Mod+Shift+TouchpadScrollUp".action.set-window-height = "+1%";
        "Mod+Shift+TouchpadScrollDown".action.set-window-height = "-1%";        
        "Mod+Shift+Equal".action.set-column-width = "+10%";
        "Mod+Minus".action.set-column-width = "-10%";
        "Mod+Equal".action.set-column-width = "50%";
        "XF86MonBrightnessUp".action.spawn = [ "brightnessctl" "set" "15%+" ];
        "XF86MonBrightnessDown".action.spawn = [ "brightnessctl" "set" "15%-" ];
        "Mod+Q".action.close-window = [];
        "Mod+Shift+Q".action.quit = [];
        "Mod+H".action.focus-column-left = [];
        "Mod+Shift+H".action.move-column-left = [];
        "Mod+J".action.focus-window-down = [];
        "Mod+Shift+J".action.move-window-down = [];
        "Mod+K".action.focus-window-up = [];
        "Mod+Shift+K".action.move-window-up = [];
        "Mod+L".action.focus-column-right = [];
        "Mod+Shift+L".action.move-column-right = [];
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
      input.touchpad.natural-scroll = true;
      input.touchpad.tap = true;
      input.touchpad.tap-button-map = "left-right-middle";

      # layout.border = {
      #   enable = true;
      #   width = 2;
      #   active.color = "rgb(255, 255, 255)";
      #   inactive.color = "rgb(80, 80, 80)";
      # };
      layout.focus-ring = {
        width = 4;
        active.color = "#a7c080";
        inactive.color = "#232a2e";
      };
      layout.center-focused-column = "on-overflow";
      layout.default-column-width.proportion = 0.5;
    };
  };
}
