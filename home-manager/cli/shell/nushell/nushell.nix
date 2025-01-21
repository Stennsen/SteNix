{ pkgs, config, lib, ... }:
{
  programs.nushell = {
    enable = true;
    envFile.text = builtins.readFile ./env.nu;
    #plugins = with pkgs.nushellPlugins [ query ];
  };
  programs.direnv.enableNushellIntegration = true;
}