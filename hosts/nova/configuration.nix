{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    # ../../roles/apps/copyparty.nix
    ../../roles/base
    ../../roles/desktop
    ../../roles/restic
    ../../roles/ssh.nix
    ../../roles/systemd-boot.nix
    ../../roles/wireguard-client.nix
  ];
}
