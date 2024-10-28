{ config, lib, ... }:
{
  programs.rio = {
    enable = true;
    settings = lib.mkDefault(builtins.readFile ./rio-config.toml);
  };
}