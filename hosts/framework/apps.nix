{ pkgs, ... }:
{
  imports = [
    ../../wrappers/firefox/firefox.nix
  ];

  environment.systemPackages = with pkgs; [
    helix
    git
    bluetui
    btop
    framework-tool
  ];

  programs = {
    direnv.enable = true;
  };

  services = {
    fwupd.enable = true;
  };
}
