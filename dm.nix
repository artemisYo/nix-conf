{ pkgs, ... }: let
  userName = "demo";
  autologin = false;
  defaultwm = "niri";
in {
  # services.xserver.enable = pkgs.lib.mkForce false;
  services.xserver.displayManager = {
    defaultSession = defaultwm;
    # needed because of fucken virtualbox default profile
    autoLogin.enable = pkgs.lib.mkForce autologin;
    autoLogin.user = userName;
    gdm = {
      enable = true;
      wayland = true;
    };
  };
}
