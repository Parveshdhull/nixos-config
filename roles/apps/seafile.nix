{
  lib,
  pkgs,
  secret-path,
  secrets,
  ...
}:
let
  config = import "${secrets}/config";
  seafileHost = (import "${secrets}/config/hosts.nix").luna;
  seafilePort = (import "${secrets}/config/ports.nix").PORT_SEAFILE;
  seafileAddress = "${seafileHost}:${toString seafilePort}";
in
{
  services.seafile = {
    user = "monu";
    dataDir = "/mnt/data/apps/seafile";
    enable = true;
    adminEmail = config.my-email-address;
    initialAdminPassword = config.seafile-initial-password;
    seahubAddress = seafileAddress;
    gc.enable = true;
    ccnetSettings.General.SERVICE_URL = "http://${seafileAddress}";
  };
}
