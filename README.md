> This repository migrated to [Codeberg](https://codeberg.org/Stennsen/SteNix)
# My NixOS configurations

## install
### If the disk has to be repartitioned
```
nix run .#framework-clean-install
```

### When a working hardware configuration exists
```
nix run .#framework-full-install
```

### partial installation steps (in order)
```
nix run .#framework-setup-disks
nix run .#framework-generate-config
nix run .#framework-install-nixos
```
