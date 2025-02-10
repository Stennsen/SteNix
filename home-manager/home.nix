{ config, pkgs, ... }:

{
  imports = [
    ./terminal/ghostty-config.nix
    ./browser/firefox/firefox-config.nix
    ./cli/shell/nushell/nushell.nix
    ./cli/editor/helix.nix
    ./cli/apps.nix
    ./editor/direnv.nix
  ];

  home.username = "stennsen";
  home.homeDirectory = "/home/stennsen";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
    tree
    fastfetch
    wget
    unzip

    ### GUI ###
    # Audio
    vlc
    pwvucontrol
    coppwr
    alsa-scarlett-gui

    # PW
    keepassxc

    # Social
    vesktop
    signal-desktop
    telegram-desktop
    tutanota-desktop

    moonlight-qt

    # Graphical Apps
    gimp
    krita
    inkscape
    scribus

    # Office
    papers # gnome PDF viewer
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {
    EDITOR = "hx";
    SHELL = "nu";
    MOZ_USE_XINPUT2 = "1";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
  };

  programs.git = {
    enable = true;
    delta.enable = true;
    ignores = [
      ".direnv"
    ];
    userEmail = "dennis@stennsen.dev";
    userName = "Stennsen";
  };

  programs.ssh = {
    enable = true;
    addKeysToAgent = "confirm";
  };

  programs.yazi = {
    enable = true;
  };
}
