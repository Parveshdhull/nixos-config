{
  pkgs,
  config,
  secret,
  ...
}:

let
  inherit (config.networking) hostName;

  serverAddress = (import ../secrets/config).server-ip;
  serverPort = (import ../secrets/config/ports.nix).wireguard;
  routeAddress = "192.168.1.1";
  interfaceName = "enp7s0";

  hosts = import ../secrets/config/hosts.nix;
  ip = hosts.${hostName};
in
{
  environment.systemPackages = with pkgs; [ wireguard-tools ];

  networking = {
    wireguard.enable = true;
    wireguard.interfaces.wg0 = {
      ips = [ "${ip}/24" ];
      listenPort = serverPort;
      privateKeyFile = secret "service/wireguard.${hostName}";
      # https://wiki.archlinux.org/index.php/WireGuard#Loop_routing
      postSetup = "ip link show ${interfaceName} &> /dev/null && ip route add ${serverAddress} via ${routeAddress} dev ${interfaceName} || true";
      peers = [
        {
          publicKey = (import ../secrets/keys).wireguard-altair; # Altair
          allowedIPs = [
            hosts.altair
            hosts.nova
            hosts.luna
            hosts.astra
          ];
          # allowedIPs = [ "0.0.0.0/0" ]; # Route whole traffic
          endpoint = "${serverAddress}:${toString serverPort}";
          persistentKeepalive = 10;
        }
      ];
    };

    firewall.allowedUDPPorts = [ serverPort ];
  };

  age.secrets."service/wireguard.${hostName}" = {
    file = ../secrets/agenix/service/wireguard/${hostName}.age;
  };
}
