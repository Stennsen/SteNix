
{ pkgs, config, ... }:
{
  programs.btop = {
    enable = true;
  };
  programs.nh = {
    enable = true;
  };
}
