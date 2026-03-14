{
  lib,
  pkgs,
  secrets,
  ...
}:
let
  hosts = import "${secrets}/config/hosts.nix";
  ports = import "${secrets}/config/ports.nix";
in
{
  networking.firewall.interfaces."enp1s0".allowedUDPPorts = [ ports.PORT_DNS ];

  services.adguardhome = {
    enable = true;
    host = hosts.luna;
    port = ports.PORT_ADGUARD;
    settings = {
      dns = {
        bind_hosts = [
          hosts.localhost
          hosts.luna-local
        ];
        port = ports.PORT_DNS;
      };
    };
  };
}
