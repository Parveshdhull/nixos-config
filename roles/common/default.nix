{
  config,
  pkgs,
  secrets,
  ...
}:

{
  imports = [
    ../base
    ./homepage.nix
    ./msmtp.nix
    ./ssh-config.nix
    ./syncthing.nix
    "${secrets}/config/env.nix"
    ../restic
    ../wireguard/wireguard-client.nix
    ../../services/initial-setup.nix
    ../../services/service-failure-notification.nix
  ];
}
