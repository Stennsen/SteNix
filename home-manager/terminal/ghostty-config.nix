
{ config, lib, ... }:
{
  programs.ghostty = {
    enable = true;
    settings = {
      window-decoration = false;
    };
  };
}
