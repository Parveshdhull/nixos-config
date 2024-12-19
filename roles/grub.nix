{
  lib,
  pkgs,
  channels,
  ...
}:

{
  boot.loader.grub = {
    efiSupport = true;
    efiInstallAsRemovable = true;
    configurationLimit = 10;
  };
}
