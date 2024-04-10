{ config, pkgs, ... }: {
  services.tlp.enable = true;
  services.tlp.settings = {
    TLP_DEFAULT_MODE = "BAT";
    START_CHARGE_THRESH_BAT0 = 60;
    STOP_CHARGE_THRESH_BAT0 = 95;
  };
  services.upower.enable = true;
}
