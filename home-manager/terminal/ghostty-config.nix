
{ config, lib, ... }:
{
  programs.ghostty = {
    enable = true;
    settings = {
      window-decoration = false;
      background-opacity = 0.85;
      # background-blur = 20;
      shell-integration-features = "no-cursor";
      cursor-style = "block";
    };
  };
}
