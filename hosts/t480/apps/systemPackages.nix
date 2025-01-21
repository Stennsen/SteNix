{ lib, pkgs, inputs, ... }:
{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    ### CLI ###
    neovim
    wget
    git

    bat
    lsd
    tree
    btop
    fastfetch

    ### GUI ###
    alacritty
    pwvucontrol
    coppwr
    alsa-scarlett-gui

    vscodium
    vesktop

    keepassxc

    signal-desktop
    telegram-desktop
    tutanota-desktop
    
    moonlight-qt
    
    gcs
    gimp
    krita
    inkscape
    vlc
    scribus
  ];
}
