{ config, pkgs, ... }:

{
  imports = [
    ./audiobookshelf.nix
    ./calibre.nix
    ./freshrss.nix
    ./immich.nix
    ./paperless.nix
  ];
}
