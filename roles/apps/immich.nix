{
  lib,
  pkgs,
  secrets,
  ...
}:
{
  services.immich = {
    database.user = "monu";
    database.name = "monu";
    enable = true;
    host = (import "${secrets}/config/hosts.nix").luna;
    mediaLocation = "/mnt/data/immich";
    machine-learning.enable = false;
    port = (import "${secrets}/config/ports.nix").PORT_IMMICH;
    user = "monu";
  };
}
