{ pkgs, config, lib, inputs, ... }:
let
  idle-pkg = ( pkgs.callPackage ../../wrappers/hypridle/hypridle.nix {} );
in
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
    brightnessctl
    mako
    swaybg
    idle-pkg
  ];

  security.polkit.enable = true; # polkit
  services.gnome.gnome-keyring.enable = true; # secret service
  security.pam.services.swaylock = {};

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    NIRI_CONFIG = "${./config.kdl}";
  };

  hardware.graphics.enable = true;

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
  
  systemd.user.services = {
    polkit-gnome-authentication-agent = {
      description = "polkit-gnome-authentication-agent";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };
  systemd.services = {
    "lock-on-sleep" = {
      description = "Lock system on suspend";
      before = [ "sleep.target" ];
      serviceConfig = {
        Type = "forking";
        ExecStart = "loginctl lock-sessions";
      };
      wantedBy = [ "sleep.target" ];
    };
  };
  programs.waybar.enable = true;
  services = {
    logind = {
      lidSwitch = "suspend";
      lidSwitchExternalPower = "suspend";
      lidSwitchDocked = "ignore";
      powerKey = "suspend";
      extraConfig = ''
        LidSwitchIgnoreInhibited=yes
      '';
    };
    # hypridle = {
    #   enable = true;
    #   package = idle-pkg;
    # };
  };
}
