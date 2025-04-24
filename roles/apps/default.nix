{ config, pkgs, ... }:

{
  imports = [
    ./audiobookshelf.nix
    ./calibre.nix
    ./immich.nix
    ./paperless.nix
  ];
}
