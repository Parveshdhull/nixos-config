{
  pkgs,
  config,
  secret,
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
      trustedInterfaces = [ "wg0" ];
    };
    # Hosts Entries
    hosts = {
      "${hosts.altair}" = [ "altair.cosmos.vpn" ]; # server
      "${hosts.nova}" = [ "nova.cosmos.vpn" ]; # pc
      "${hosts.luna}" = [ "luna.cosmos.vpn" ]; # lappy
      "${hosts.astra}" = [ "astra.cosmos.vpn" ]; # phone
    };
    # Search the cosmos domain
    enableIPv6 = false;
    domain = "cosmos.vpn";
    search = [ "cosmos.vpn" ];
  };
  networking.nameservers = [
    "1.1.1.1"
    "1.0.0.1"
  ];
}
