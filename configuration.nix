{ config, pkgs, ... }:

{
  imports = [ 
    <nixpkgs/nixos/modules/installer/virtualbox-demo.nix> 
  ];
  nix.settings.trusted-users = [ "demo" ];

  time.timeZone = "Europe/Berlin";

# By default, the NixOS VirtualBox demo image includes SDDM and Plasma.
# If you prefer another desktop manager or display manager, you may want
# to disable the default.
  services.xserver.desktopManager.plasma5.enable = pkgs.lib.mkForce false;
  services.xserver.displayManager.sddm.enable = pkgs.lib.mkForce false;
  # as I'm using lightdm
  # services.xserver.enable = pkgs.lib.mkForce false;

# environment.systemPackages = with pkgs; [
#   wget vim
# ];
}
