{
  lib,
  pkgs,
  secrets,
  ...
}:
let
  ports = import "${secrets}/config/ports.nix";
in
{
  networking.firewall.interfaces."enp1s0".allowedUDPPorts = [ ports.PORT_DNS ];

  services.adguardhome = {
    enable = true;
    host = (import "${secrets}/config/hosts.nix").luna;
    port = ports.PORT_ADGUARD;
  };
}
