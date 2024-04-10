{ pkgs, ... }: let
  userName = "artemis";
  autologin = false;
  defaultwm = "niri";
in {
  services.xserver.enable = true;
  services.xserver.displayManager = {
    defaultSession = defaultwm;
    autoLogin.enable = autologin;
    autoLogin.user = userName;
    gdm = {
      enable = true;
      wayland = true;
    };
  };
}
