{ config, inputs, ... }:
let
  theme = "mocha";
  color = "blue";
in 
{
  imports = [
    inputs.catppuccin.nixosModules.catppuccin
  ];

  catppuccin = {
    enable = true;
    flavor = theme;
    accent = color;
  };
  
  home-manager.users."stennsen".imports = [
    inputs.catppuccin.homeModules.catppuccin
    {
      catppuccin = {
        enable = true;
        flavor = theme;
        accent = color;
        mako.enable = false; # https://github.com/catppuccin/nix/issues/552#issuecomment-2849046838
      };
    }
  ];
}
