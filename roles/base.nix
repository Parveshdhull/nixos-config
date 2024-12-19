{ config, pkgs, ... }:

{
  imports = [
    ./basic-tools.nix
    ./helpers.nix
    ./homepage.nix
    ./networking.nix
    ./security.nix
    ./syncthing.nix
    ./users.nix
    ../secrets/config/env.nix
    ../services/initial-setup.nix
  ];

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
