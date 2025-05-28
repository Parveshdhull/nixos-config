{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../roles/base
    ../../roles/desktop
    ../../roles/restic
    ../../roles/systemd-boot.nix
    ../../roles/wireguard-client.nix
  ];
}
