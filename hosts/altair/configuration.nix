{ pkgs, ... }:

{
  imports = [
    ./disk-config.nix
    ./hardware-configuration.nix
    ../../roles/apps/jellyfin.nix
    ../../roles/base
    ../../roles/base/janitor.nix
    ../../roles/server
    ../../roles/ssh.nix
    ../../services/alertbot.nix
    ../../services/signal-cli-monitor.nix
  ];

  networking.nameservers = [
    "1.1.1.1"
    "1.0.0.1"
  ];
}
