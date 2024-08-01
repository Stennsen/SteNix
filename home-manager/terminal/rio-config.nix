{ config, ... }:
{
  programs.rio = {
    enable = true;
    #settings = builtins.readFile ./rio-config.toml;
  };
}