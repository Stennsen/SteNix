{ pkgs, config, ... }:
{
  home.shell.enableFishIntegration = true;
  programs = {
    fish = {
      enable = true;
      shellInit = ''
        set -Ux FLAKE "/home/stennsen/.config/nixos"
        set -Ux fish_greeting
      '';
    };
    ghostty.enableFishIntegration = true;
    starship = {
      enable = true;
      enableFishIntegration = true;
      settings = (builtins.fromTOML (builtins.readFile ../shell/nushell/starship.toml));
    };
  };
}
