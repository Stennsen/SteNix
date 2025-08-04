{ config, pkgs, inputs, ... }:
{
  # enable SR-IOV
  # imports = [
  #   inputs.i915-sriov.nixosModules.default
  # ];
  # boot.extraModulePackages = [ pkgs.i915-sriov ];

  # enable virt-manager and spice
  programs.virt-manager.enable = true;
  virtualisation = {
    # cyberus.intel-graphics-sriov.enable = true;
    libvirtd.enable = true;
    # Enable TPM emulation (optional)
    libvirtd.qemu = {
      swtpm.enable = true;
      ovmf.packages = [ pkgs.OVMFFull.fd ];
    };
    kvmgt.enable = true;
    # Enable USB redirection (optional)
    spiceUSBRedirection.enable = true;
  };
  # enable default libvirt NAT
  networking.firewall.trustedInterfaces = [ "virbr0" ];
}
