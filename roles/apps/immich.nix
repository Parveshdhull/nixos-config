{
  lib,
  pkgs,
  secrets,
  ...
}:
{
  services.immich = {
    enable = true;
    host = (import "${secrets}/config/hosts.nix").luna;
    mediaLocation = "/mnt/data/immich";
    machine-learning.enable = false;
    port = (import "${secrets}/config/ports.nix").PORT_IMMICH;
  };

  users.users.restic.extraGroups = [ "immich" ];
}
