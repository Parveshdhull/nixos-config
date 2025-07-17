{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../roles/base
    ../../roles/ssh.nix
    ../../roles/systemd-boot.nix
  ];
}
