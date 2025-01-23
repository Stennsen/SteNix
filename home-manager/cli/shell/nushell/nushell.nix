{ pkgs, config, lib, ... }:
{
  programs.nushell = {
    enable = true;
    envFile.text = builtins.readFile ./env.nu;
    #plugins = with pkgs.nushellPlugins [ query ];
    extraConfig = ''
      $env.config.show_banner = false
    '';
  };
  programs.direnv.enableNushellIntegration = true;
  programs.starship = {
    enable = true;
    enableNushellIntegration = true;
    settings = (builtins.fromTOML (builtins.readFile ./starship.toml));
  };
}
