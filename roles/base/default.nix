{
  config,
  pkgs,
  secrets,
  ...
}:

{
  imports = [
    ./basic-tools.nix
    ./helpers.nix
    ./homepage.nix
    ./janitor.nix
    ./msmtp.nix
    ./networking.nix
    ./security.nix
    ./ssh-config.nix
    ./syncthing.nix
    ./users.nix
    "${secrets}/config/env.nix"
    ../../services/initial-setup.nix
    ../../services/service-failure-notification.nix
  ];

  # https://discourse.nixos.org/t/nixos-rebuild-switch-upgrade-networkmanager-wait-online-service-failure/30746/2
  systemd.services.NetworkManager-wait-online.enable = false;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  services.locate.enable = true;

  #Secrets
  age.identityPaths = [ "/mnt/secrets/keys/${config.networking.hostName}" ];

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";
  # Avoid difference when dual-booting
  time.hardwareClockInLocalTime = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.05";
}
