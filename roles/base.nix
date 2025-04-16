{
  config,
  pkgs,
  secrets,
  ...
}:

{
  imports = [
    ./base/basic-tools.nix
    ./base/helpers.nix
    ./base/homepage.nix
    ./base/msmtp.nix
    ./base/networking.nix
    ./base/security.nix
    ./base/ssh-config.nix
    ./base/syncthing.nix
    ./base/users.nix
    "${secrets}/config/env.nix"
    ../services/initial-setup.nix
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
