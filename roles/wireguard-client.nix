{
  pkgs,
  config,
  secret-path,
  secrets,
  ...
}:

let
  inherit (config.networking) hostName;

  keys = import "${secrets}/keys";
  hosts = import "${secrets}/config/hosts.nix";
  serverAddress = (import "${secrets}/config").server-ip;
  serverPort = (import "${secrets}/config/ports.nix").PORT_WIREGUARD;

  routeAddress = "192.168.1.1";
  interfaceName = "enp7s0";
  ip = hosts.${hostName};
in
{
  environment.systemPackages = with pkgs; [ wireguard-tools ];

  networking = {
    wireguard.enable = true;
    wireguard.interfaces.wg0 = {
      ips = [ "${ip}/24" ];
      listenPort = serverPort;
      privateKeyFile = secret-path "service/wireguard.${hostName}";
      # https://wiki.archlinux.org/index.php/WireGuard#Loop_routing
      postSetup = "ip link show ${interfaceName} &> /dev/null && ip route add ${serverAddress} via ${routeAddress} dev ${interfaceName} || true";
      peers = [
        {
          publicKey = (import "${secrets}/keys").wireguard-altair; # Altair
          allowedIPs = [
            hosts.altair
            hosts.nova
            hosts.luna
            hosts.astra
            # "0.0.0.0/0" # Route whole traffic
          ];
          endpoint = "${serverAddress}:${toString serverPort}";
          persistentKeepalive = 10;
        }
        # Only keep these peers when using enp7s0; otherwise, their endpoints won't be reachable.
        {
          publicKey = keys.wireguard-nova;
          allowedIPs = [ "${hosts.nova}/32" ];
          persistentKeepalive = 10;
          endpoint = "${hosts.nova-local}:${toString serverPort}";
        }
        {
          publicKey = keys.wireguard-luna;
          allowedIPs = [ "${hosts.luna}/32" ];
          persistentKeepalive = 10;
          endpoint = "${hosts.luna-local}:${toString serverPort}";
        }
      ];
    };

    firewall.allowedUDPPorts = [ serverPort ];
  };

  age.secrets."service/wireguard.${hostName}" = {
    file = "${secrets}/agenix/service/wireguard/${hostName}.age";
  };
}
