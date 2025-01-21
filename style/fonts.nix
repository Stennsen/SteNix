{ config, pkgs, ... }:
{
  
  fonts.packages = with pkgs; [
    nerd-fonts.zed-mono
    dejavu_fonts
    noto-fonts-color-emoji
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [ "ZedMono" ];
      sansSerif = [ "DejaVu Sans" ];
      serif = [ "DejaVu Serif" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };
}