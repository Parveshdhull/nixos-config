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
    ./janitor.nix
    ./networking.nix
    ./security.nix
    ./ssh.nix
    ./systemd-boot.nix
    ./users.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.config.allowUnfree = true;

  services.locate.enable = true;

  # https://discourse.nixos.org/t/nixos-rebuild-switch-upgrade-networkmanager-wait-online-service-failure/30746/2
  systemd.services.NetworkManager-wait-online.enable = false;

  #Secrets
  age.identityPaths = [ "/mnt/secrets/keys/${config.networking.hostName}" ];

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.05";
}
