{ lib, pkgs, ... }:

{
  # Start virbr0
  # sudo virsh net-start default
  # sudo virsh net-autostart default
  virtualisation.libvirtd.enable = true;

  boot.kernelModules = [
    "bridge"
    "tap"
  ];

  security.wrappers.qemu-bridge-helper = {
    setuid = true;
    owner = "root";
    group = "root";
    source = "${pkgs.qemu}/libexec/qemu-bridge-helper";
  };
}
