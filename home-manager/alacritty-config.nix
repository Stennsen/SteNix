{ pkgs, ... }:
{
  programs.alacritty = {
    enable = true;
    package = pkgs.alacritty;
    settings = {
      window = {
        padding = {
          x = 15;
          y = 15;
        };
        blur = false;
        opacity = 0.7;
      };
    };
  };
}
