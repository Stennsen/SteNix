{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin.url = "github:catppuccin/nix";

    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.t480 = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./hosts/t480/configuration.nix
        ./desktop/cosmic.nix
        ./home-manager/home-manager.nix
        ./virtualization/container.nix
        ./style/catppuccin.nix
        ./style/cursor.nix
        ./style/fonts.nix
        inputs.home-manager.nixosModules.default
        inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t480
      ];
    };

    nixosConfigurations.xps = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./hosts/xps/configuration.nix
        ./desktop/hyprland.nix
        ./home-manager/home-manager.nix
        ./virtualization/container.nix
        ./virtualization/virtual-machine.nix
        ./style/stylix.nix
        inputs.stylix.nixosModules.stylix
        inputs.home-manager.nixosModules.default
        inputs.nixos-hardware.nixosModules.dell-xps-15-9570
      ];
    };
  };
}
