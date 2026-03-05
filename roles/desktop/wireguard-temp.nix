{
  pkgs,
  config,
  secret-path,
  secrets,
  ...
}:

let
  keys = import "${secrets}/keys";
  hosts = import "${secrets}/config/hosts.nix";
  serverAddress = (import "${secrets}/config").server2-ip;
  serverPort = (import "${secrets}/config/ports.nix").PORT_WIREGUARD_SERVER2;

  routeAddress = "192.168.1.1";
  interfaceName = "enp7s0";
  ip = hosts.nova-temp;
in
{
  environment.systemPackages = with pkgs; [ wireguard-tools ];

  networking = {
    wireguard.enable = true;
    wireguard.interfaces.wg1 = {
      ips = [ "${ip}/24" ];
      listenPort = serverPort;
      privateKeyFile = secret-path "service/wireguard.nova-temp";
      # https://wiki.archlinux.org/index.php/WireGuard#Loop_routing
      postSetup = "ip link show ${interfaceName} &> /dev/null && ip route add ${serverAddress} via ${routeAddress} dev ${interfaceName} || true";
      peers = [
        {
          publicKey = (import "${secrets}/keys").wireguard-server2;
          allowedIPs = [
            # hosts.server2
            "0.0.0.0/0" # Route whole traffic
          ];
          endpoint = "${serverAddress}:${toString serverPort}";
          persistentKeepalive = 10;
        }
      ];
    };

    firewall.allowedUDPPorts = [ serverPort ];
  };

  age.secrets."service/wireguard.nova-temp" = {
    file = "${secrets}/agenix/service/wireguard/nova-temp.age";
  };
}
