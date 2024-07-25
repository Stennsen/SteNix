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
    inputs.catppuccin.homeManagerModules.catppuccin
    {
      catppuccin = {
        enable = true;
        flavor = theme;
        accent = color;
      };
    }
  ];
}