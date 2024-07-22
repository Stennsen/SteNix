{ lib, config, pkgs, ... }:

{
  imports = [
    ./sound.nix
  ];
  # options = {
  #   desktop-environment.enable = lib.mkEnableOption "enable desktop module";
  # };

    services.xserver ={
      enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };

    environment.gnome.excludePackages = environment.systemPackages.optionalPackages;


}
