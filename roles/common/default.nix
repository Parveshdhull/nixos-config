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
    ./networking.nix
    ./ssh-config.nix
    ./syncthing.nix
    ./users.nix
    "${secrets}/config/env.nix"
    ../../services/initial-setup.nix
    ../../services/service-failure-notification.nix
  ];

  # https://discourse.nixos.org/t/nixos-rebuild-switch-upgrade-networkmanager-wait-online-service-failure/30746/2
  systemd.services.NetworkManager-wait-online.enable = false;

  #Secrets
  age.identityPaths = [ "/mnt/secrets/keys/${config.networking.hostName}" ];

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";
}
