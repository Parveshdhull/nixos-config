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
    dig
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
    # Search the cosmos domain
    search = [ "cosmos.vpn" ];

    domain = "cosmos.vpn"; # 🌌 Infinite tapestry — the celestial web that binds us all

    # Hosts Entries - each a shining beacon within the cosmos
    hosts = {
      "${hosts.altair}" = [ "altair.cosmos.vpn" ]; # 🛰️ Guiding star — steady and central
      "${hosts.nova}" = [ "nova.cosmos.vpn" ]; # 💥 Stellar burst — powerful and radiant
      # 🌙 Lunar anchor — calm and ever-present
      "${hosts.luna}" = [
        "luna.cosmos.vpn"
        "grocy.luna.cosmos.vpn"
        "rss.luna.cosmos.vpn"
      ];
      "${hosts.astra}" = [ "astra.cosmos.vpn" ]; # 📡 Celestial messenger — light and fast
      "${hosts.lyra}" = [ "lyra.cosmos.vpn" ]; # 🎶 Harmonic traveler — graceful and portable
      "${hosts.cielo}" = [ "cielo.cosmos.vpn" ]; # ☁️ Open sky — peaceful and connected
    };
  };
}
