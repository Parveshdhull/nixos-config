{ pkgs, ... }:

{
  imports = [
    ./disk-config.nix
    ./hardware-configuration.nix
    ../../roles/base
    ../../roles/server
    ../../roles/ssh.nix
    ../../services/alertbot.nix
    ../../services/service-failure-notification.nix
    ../../services/signal-cli-monitor.nix
  ];
}
