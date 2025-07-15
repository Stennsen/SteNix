{ config, pkgs, lib, ... }:
{
  
  fonts.packages = builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts) ++ (with pkgs; [
    # google-fonts
    dejavu_fonts
    noto-fonts-color-emoji
  ]);

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
