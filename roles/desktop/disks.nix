{ pkgs, ... }:

{
  fileSystems = {
    "/mnt/backups" = {
      device = "/dev/disk/by-label/backups";
    };
    "/mnt/data" = {
      device = "/dev/disk/by-label/data";
    };
    "/mnt/storagebox-nova" = {
      device = "/dev/disk/by-label/storagebox-nova";
    };
  };
}
