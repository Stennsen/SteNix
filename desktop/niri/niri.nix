{ pkgs, config, lib, inputs, ... }:
{
  imports = [
    ../sound.nix
    ../../style/fonts.nix
  ];

  programs.niri = {
    enable = true;
    package = pkgs.niri;
  };
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gnome
      gnome-keyring
    ];
  };

  environment.systemPackages = with pkgs; [
    alacritty
    fuzzel
    swaylock
    brightnessctl
    mako
    waybar
    swaybg
    swayidle
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    NIRI_CONFIG = "${./config.kdl}";
  };

  hardware.graphics.enable = true;
  security.polkit.enable = true;

  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd niri-session";
        user = "greeter";
      };
      default_session = initial_session;
    };
  };

  # systemd.user.services = {
  #   niri = {
  #     # wants = [ "mako.service" "waybar.service" ];
  #     environment = {
  #       NIRI_CONFIG = "${./config.kdl}";
  #     };
  #   };
  # };
}
