{ pkgs, config, inputs, ... }:
{
  nix.settings = {
    substituters = [ "https://cosmic.cachix.org/" ];
    trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
  };
  imports = [
    inputs.nixos-cosmic.nixosModules.default
    ./sound.nix
  ];
  
  services = {
    desktopManager.cosmic.enable = true;
    displayManager.cosmic-greeter.enable = true;

    flatpak.enable = false;
  };
  
  environment.cosmic.excludePackages = with pkgs; [
    cosmic-edit
    cosmic-term
    cosmic-store
  ];
}