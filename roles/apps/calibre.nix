{
  lib,
  pkgs,
  secrets,
  ...
}:
{
  services.calibre-web = {
    user = "monu";
    enable = true;
    listen.ip = (import "${secrets}/config/hosts.nix").luna;
    listen.port = (import "${secrets}/config/ports.nix").PORT_CALIBRE_WEB;
    options = {
      enableBookUploading = true;
      enableBookConversion = true;
      calibreLibrary = "/mnt/data/apps/calibre";
    };
  };
}
