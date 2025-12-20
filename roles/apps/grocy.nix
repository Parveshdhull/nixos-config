{
  lib,
  pkgs,
  secret-path,
  secrets,
  ...
}:

{
  services.grocy = {
    enable = true;
    hostName = "grocy.luna.cosmos.vpn";
    dataDir = "/mnt/data/apps/grocy";
    settings.currency = "INR";
    nginx.enableSSL = false;
  };

  users.users.restic.extraGroups = [ "nginx" ];
}
