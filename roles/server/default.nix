{ config, pkgs, ... }:

{
  imports = [
    ./signal-cli.nix
    ./wireguard-server.nix
  ];
}
