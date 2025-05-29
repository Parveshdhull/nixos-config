{
  pkgs,
  config,
  secrets,
  ...
}:

let
  hosts = import "${secrets}/config/hosts.nix";
in
{
  environment.systemPackages = with pkgs; [
    curl
    wget
  ];

  networking = {
    networkmanager.enable = true;
    # Firewall
    firewall = {
      # Open firewall for connections from Wireguard
      trustedInterfaces = [
        "wg0"
      ];
    };
    # Hosts Entries
    hosts = {
      "${hosts.altair}" = [ "altair.cosmos.vpn" ]; # server
      "${hosts.nova}" = [ "nova.cosmos.vpn" ]; # pc
      "${hosts.luna}" = [ "luna.cosmos.vpn" ]; # lappy
      "${hosts.astra}" = [ "astra.cosmos.vpn" ]; # phone
      "${hosts.cielo}" = [ "cielo.cosmos.vpn" ]; # cielo
    };
    # Search the cosmos domain
    domain = "cosmos.vpn";
    search = [ "cosmos.vpn" ];
  };
}
