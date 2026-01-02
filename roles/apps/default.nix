{ config, pkgs, ... }:

{
  imports = [
    ./adguard-home.nix
    ./audiobookshelf.nix
    ./calibre.nix
    ./copyparty.nix
    ./freshrss.nix
    ./grocy.nix
    ./immich.nix
    ./memos.nix
    ./paperless.nix
  ];
}
