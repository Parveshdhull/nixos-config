{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    # ../../roles/apps/copyparty.nix
    ../../roles/common
    ../../roles/desktop
    ../../roles/restic
    ../../roles/ssh.nix
    ../../roles/systemd-boot.nix
    ../../roles/wireguard-client.nix
  ];
}
