{ lib, pkgs, ... }:
{
  services.audiobookshelf = {
    user = "monu";
    enable = true;
    host = (import ../secrets/config/hosts.nix).luna;
    port = (import ../secrets/config/ports.nix).audiobookshelf;
  };
}
