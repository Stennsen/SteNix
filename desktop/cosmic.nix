{ pkgs, config, inputs, ... }:
{
  imports = [
    ./sound.nix
  ];
  
  services = {
    desktopManager.cosmic.enable = true;
    desktopManager.cosmic.xwayland.enable = true;
    displayManager.cosmic-greeter.enable = true;

    flatpak.enable = true;
  };

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
  };
  
  # environment.cosmic.excludePackages = with pkgs; [
  #   cosmic-edit
  #   cosmic-term
  #   cosmic-store
  # ];
}
