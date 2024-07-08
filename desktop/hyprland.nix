{ pkgs, lib, inputs, ... }:
let
  hyprland_package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
in

{
  services.logind.extraConfig = ''
    # don’t shutdown when power button is short-pressed
    HandlePowerKey=ignore
    HandleLidSwitch=suspend
  '';

  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  imports = [
    ./sound.nix
  ];

  environment.systemPackages = with pkgs; [
    hypridle
    hyprlock
  ];
  # enable PAM for hyprlock
  security.pam.services.hyprlock = {};

  programs.hyprland = {
    enable = true;
    package = hyprland_package;
    xwayland.enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [
      #inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };

  hardware = {
    graphics.enable = true;
  };

  security.polkit.enable = true;

  #autologin
  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
        user = "greeter";
      };
      default_session = initial_session;
    };
  };
}
