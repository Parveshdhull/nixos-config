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
    ./monitor.nix
    ./networking.nix
    ./samba.nix
    ./security.nix
    ./systemd-boot.nix
    ./users.nix
  ];

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    max-jobs = 4;
    cores = 2;
  };

  swapDevices = [
    {
      device = "/swapfile";
      size = 8 * 1024;
    }
  ];

  nixpkgs.config.allowUnfree = true;

  services.locate.enable = true;

  boot.kernelParams = [ "ipv6.disable=1" ];

  # https://discourse.nixos.org/t/nixos-rebuild-switch-upgrade-networkmanager-wait-online-service-failure/30746/2
  systemd.services.NetworkManager-wait-online.enable = false;

  #Secrets
  age.identityPaths = [ "/mnt/secrets/keys/${config.networking.hostName}" ];

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.05";
}
