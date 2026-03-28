{ pkgs, ... }:

{
  imports = [
    ./disk-config.nix
    ./hardware-configuration.nix
    ../../roles/base
    ../../roles/wireguard/wireguard-server.nix
    ../../roles/sshd.nix
    ../../services/initial-setup.nix
  ];

  networking.nameservers = [
    "1.1.1.1"
    "1.0.0.1"
  ];
}
