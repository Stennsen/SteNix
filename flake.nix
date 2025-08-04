{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
    };
    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence.url = "github:nix-community/impermanence";
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # way-edges = {
    #   url = "github:way-edges/way-edges/8a8819d2ddbcf3a7f1105ec969519937da272cbd";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations = {
      framework = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          inputs.nixos-hardware.nixosModules.framework-11th-gen-intel
          ./hosts/framework/configuration.nix
          ./desktop/niri/niri.nix
          ./users/stennsen.nix
          ./settings/locale.nix
          ./virtualization/virtual-machine.nix
          ./style/stylix.nix
        ];
      };
    };

    apps =
      let
        pkgs = import nixpkgs { system = "x86_64-linux"; };
        lib = nixpkgs.lib;
        framework-setup-disks = pkgs.writeShellScript "framework-setup-disks" ''
            set -euo pipefail
            echo "

            =========================
            === configuring disks ===
            =========================

            "
            sudo ${inputs.disko}/disko --mode destroy,format,mount ${./hosts/framework/disks.nix}
          '';
        framework-generate-config = pkgs.writeShellScript "framework-generate-config" ''
            set -euo pipefail
            echo "

            =======================
            === creating config ===
            =======================

            "
            sudo nixos-generate-config --no-filesystems --show-hardware-config --root /mnt > ./hosts/framework/hardware-configuration.nix
            git add ./hosts/framework/hardware-configuration.nix
          '';
        framework-install-nixos = pkgs.writeShellScript "framework-install-nixos" ''
            set -euo pipefail
            echo "

            ========================
            === installing NixOS ===
            ========================

            "
            sudo mkdir -p /mnt/etc
            sudo cp -r ./. /mnt/etc/nixos
            sudo cp -r ./. /mnt/persist/etc/nixos
            sudo nixos-install --flake /mnt/etc/nixos#framework --no-root-passwd
          '';
        framework-full-install = pkgs.writeShellScript "framework-full-install" ''
            set -euo pipefail
            ${framework-setup-disks}
            ${framework-install-nixos}
          '';
        framework-clean-install = pkgs.writeShellScript "framework-full-install" ''
            set -euo pipefail
            ${framework-setup-disks}
            ${framework-generate-config}
            ${framework-install-nixos}
          '';
      in
      {
        x86_64-linux = {
          framework-setup-disks = { type = "app"; program = "${framework-setup-disks}"; };
          framework-generate-config = { type = "app"; program = "${framework-generate-config}"; };
          framework-install-nixos = { type = "app"; program = "${framework-install-nixos}"; };
          framework-full-install = { type = "app"; program = "${framework-full-install}"; };
          framework-clean-install = { type = "app"; program = "${framework-clean-install}"; };
        };
      };
  };
}
