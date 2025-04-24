{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../roles/base
    ../../roles/desktop
    ../../roles/restic
    ../../roles/signal-cli.nix
    ../../roles/systemd-boot.nix
    ../../roles/wireguard-client.nix
  ];
}
