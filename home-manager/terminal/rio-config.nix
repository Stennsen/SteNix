{ config, lib, ... }:
{
  programs.rio = {
    enable = true;
    settings = lib.mkForce(lib.importTOML ./rio-config.toml);
  };
}
