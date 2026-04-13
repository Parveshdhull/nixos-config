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
      peers = [
        {
          publicKey = keys.wireguard-server2;
          allowedIPs = [
            "0.0.0.0/0" # Route whole traffic
            # hosts.server2
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
