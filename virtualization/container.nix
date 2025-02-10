{ pkgs, config, ... }:
{
  # Enable common container config files in /etc/containers
  virtualisation.containers.enable = true;
  virtualisation = {
    podman = {
      enable = true;
      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;
      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  users.groups.podman.members = [ "stennsen" ];

  environment.systemPackages = with pkgs; [
    podman-compose
    podman-desktop
  ];
}
