{ pkgs, ... }:

{
  fileSystems."/mnt/data" = {
    device = "/dev/disk/by-label/data";
  };

  fileSystems."/mnt/storagebox-nova" = {
    device = "/dev/disk/by-label/storagebox-nova";
  };
}
