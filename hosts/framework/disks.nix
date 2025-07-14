{
  disko.devices = {
    # /tmp is included in this root
    nodev."/" = {
      fsType = "tmpfs";
      mountOptions = [
        "defaults"
        "size=2G"
        "mode=755"
      ];
    };

    disk.main = {
      type = "disk";
      device = "/dev/nvme0n1";

      content = {
        type = "gpt";
        partitions = {
          ESP = {
            size = "1024M";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = [
                "umask=0077"
              ];
            };
          };

          luks = {
            size = "100%";
            content = {
              type = "luks";
              name = "crypted";
              # disable settings.keyFile if you want to use interactive password entry
              # passwordFile = "/tmp/secret.key"; # Interactive
              settings = {
                allowDiscards = true;
                # keyFile = "/tmp/secret.key";
              };
              # additionalKeyFiles = [ "/tmp/additionalSecret.key" ];
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ];
                subvolumes = {
                  nix-store = {
                    mountpoint = "/nix";
                    mountOptions = [
                      "compress=lzo"
                      "noatime"
                    ];
                  };
                  persist = {
                    mountpoint = "/persist";
                    mountOptions = [
                      "compress=lzo"
                      "noatime"
                    ];
                  };
                  swap = {
                    mountpoint = "/swap";
                    mountOptions = [ "noatime" ];
                    swap.swapfile.size = "32G";
                  };
                };
              };
            };
          };
        };
      };
    };
  };
  fileSystems."/persist".neededForBoot = true;
}
