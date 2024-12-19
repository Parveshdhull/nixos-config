{ pkgs, ... }:

{
  imports = [
    ./disk-config.nix
    ./hardware-configuration.nix
    ../../roles/base.nix
    ../../roles/janitor.nix
    ../../roles/msmtp.nix
    ../../roles/signal-cli.nix
    ../../roles/ssh.nix
    ../../roles/wireguard-server.nix
    ../../services/alertbot.nix
    ../../services/market-price-checker.nix
    ../../services/service-failure-notification.nix
    ../../services/signal-cli-monitor.nix
  ];
}
