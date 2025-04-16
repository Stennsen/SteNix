{ pkgs, config, inputs, ... }:
{
  imports = [
    ./sound.nix
  ];
  
  services = {
    desktopManager.cosmic.enable = true;
    displayManager.cosmic-greeter.enable = true;

    flatpak.enable = true;
  };
  
  # environment.cosmic.excludePackages = with pkgs; [
  #   cosmic-edit
  #   cosmic-term
  #   cosmic-store
  # ];
}
