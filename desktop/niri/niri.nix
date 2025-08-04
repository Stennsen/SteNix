{ pkgs, config, lib, inputs, ... }:
let
  background-image = pkgs.fetchurl {
     url = "https://cdna.artstation.com/p/assets/images/images/061/675/990/large/eugene-siryk-deezerroom1-night1-2160.jpg";
     sha256 = "xve3FnuLqW9DHAhCjNp3Zr/eEzVzMTx10Zqo+iPf/QE=";
   };

  idle-pkg = ( pkgs.callPackage ../../wrappers/swayidle/swayidle.nix {} );
  idle-cmd = "${idle-pkg}/bin/swayidle";
  lock-pkg = ( pkgs.callPackage ../../wrappers/hyprlock/hyprlock.nix {} );

  installed-pkgs = with pkgs; [
    alacritty
    fuzzel
    mako
    brillo
    lock-pkg
    wdisplays
  ] ++ [
    # inputs.way-edges.packages."${pkgs.system}".way-edges
  ];
in
{
  imports = [
    ../sound.nix
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    NIRI_CONFIG = "${./config.kdl}";
  };

  environment.systemPackages = installed-pkgs;

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


  security.polkit.enable = true; # polkit
  services.gnome.gnome-keyring.enable = true; # secret service
  security.pam.services.swaylock = {};

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
    swayidle = {
      description = "swayidle on niri";
      partOf = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      requisite = [ "graphical-session.target" ];
      wantedBy = [ "niri.service" ];
      serviceConfig = {
        ExecStart = idle-cmd;
        Restart = "on-failure";
      };
    };
    background = {
      description = "desktop background";
      partOf = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      requisite = [ "graphical-session.target" ];
      wantedBy = [ "niri.service" ];
      serviceConfig = {
        ExecStart = "${pkgs.wbg}/bin/wbg ${background-image}";
        Restart = "on-failure";
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
        ExecStartPost = "${pkgs.coreutils-full}/bin/sleep 1";
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
  };
}
