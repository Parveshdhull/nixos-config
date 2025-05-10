{
  pkgs,
  systemd,
  config,
  ...
}:

{
  nix.gc = {
    automatic = if config.networking.hostName == "nova" then false else true;
    dates = "daily";
    options = "--delete-older-than 15d";
  };

  services.journald.extraConfig = ''
    SystemMaxUse=500M
    SystemKeepFree=100M
    SystemMaxFileSize=50M
    SystemMaxFiles=10
  '';

  # Whether to delete all files in /tmp during boot
  boot.tmp.cleanOnBoot = true;
}
