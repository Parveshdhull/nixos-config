{ config, pkgs, ... }:

{
  imports = [
    ./adguard-home.nix
    ./audiobookshelf.nix
    ./calibre.nix
    ./freshrss.nix
    ./immich.nix
    ./paperless.nix
  ];
}
