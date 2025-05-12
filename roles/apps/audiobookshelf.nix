{
  lib,
  pkgs,
  secrets,
  ...
}:
{
  services.audiobookshelf = {
    user = "monu";
    enable = true;
    host = (import "${secrets}/config/hosts.nix").luna;
    port = (import "${secrets}/config/ports.nix").PORT_AUDIOBOOHSHELF;
  };
}
