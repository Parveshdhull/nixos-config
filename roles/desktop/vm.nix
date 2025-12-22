{ pkgs, secrets, ... }:
{
  virtualisation.libvirtd.enable = true;
  boot.kernelModules = [ "kvm-amd" ];
  users.users.monu.extraGroups = [ "libvirtd" ];
}
