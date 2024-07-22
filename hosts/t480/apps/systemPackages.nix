{ lib, pkgs, inputs, ... }:
{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    ### CLI ###
    neovim
    wget
    fastfetch
    git

    bat

    ### GUI ###
    alacritty
    nwg-displays
    pwvucontrol
    coppwr
    alsa-scarlett-gui

    zed-editor
    vscodium
    vesktop
    keepassxc
  ];
  
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-media-tags-plugin
      thunar-archive-plugin
      thunar-volman
    ];
  };
  services.gvfs.enable = true;
  services.tumbler.enable = true;
  programs.xfconf.enable = true;
}
