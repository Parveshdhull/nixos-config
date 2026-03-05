{
  lib,
  pkgs,
  channels,
  ...
}:

{
  boot.loader = {
    grub.enable = false;
    systemd-boot = {
      enable = true;
      configurationLimit = 20;
    };
  };
}
