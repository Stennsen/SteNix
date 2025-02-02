
{ pkgs, ... }:
{
  programs.btop = {
    enable = true;
  };
  programs.nh = {
    enable = true;
    flake = ../..;
  };
}
