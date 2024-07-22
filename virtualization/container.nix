{ pkgs, config, ... }:
{
  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  users.extraGroups.docker.members = [ "stennsen" ];

  # for btrfs
  # virtualisation.docker.storageDriver = "btrfs";

  environment.systemPackages = [
    pkgs.distrobox
  ];

  # Enable common container config files in /etc/containers
  virtualisation.containers.enable = true;
  virtualisation = {
    podman = {
      enable = true;
      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = false;
    };
  };
}
