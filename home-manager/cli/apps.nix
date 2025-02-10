
{ pkgs, config, ... }:
{
  programs.bottom = {
    enable = true;
  };
  programs.nh = {
    enable = true;
  };
}
