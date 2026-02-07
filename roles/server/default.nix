{ config, pkgs, ... }:

{
  imports = [
    ./changedetection.nix
    ./signal-cli.nix
    ./wireguard-server.nix
  ];
}
