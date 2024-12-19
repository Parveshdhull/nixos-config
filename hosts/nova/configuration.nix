{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../roles/base.nix
    ../../roles/desktop.nix
    ../../roles/restic/configuration.nix
    ../../roles/signal-cli.nix
    ../../roles/systemd-boot.nix
    ../../roles/wireguard-client.nix
  ];
}
