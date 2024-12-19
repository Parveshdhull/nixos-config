{
  pkgs,
  config,
  secret,
  secrets,
  ...
}:

let
  hosts = import "${secrets}/config/hosts.nix";
  keys = import "${secrets}/keys";
in
{
  age.secrets."service/wireguard/altair" = {
    file = "${secrets}/agenix/service/wireguard/altair.age";
  };

  boot.kernel.sysctl."net.ipv4.ip_forward" = 1;

  environment.systemPackages = with pkgs; [ wireguard-tools ];

  networking = {
    nat = {
      enable = true;
      externalInterface = "enp1s0";
      internalInterfaces = [ "wg0" ];
    };

    firewall.allowedUDPPorts = [ (import "${secrets}/config/ports.nix").wireguard ];

    wireguard.enable = true;
    wireguard.interfaces.wg0 = {
      ips = [ "${hosts.altair}/24" ];
      listenPort = (import "${secrets}/config/ports.nix").wireguard;
      postSetup = "${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 10.100.0.0/24 -o eth0 -j MASQUERADE";
      postShutdown = "${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s 10.100.0.0/24 -o eth0 -j MASQUERADE";
      privateKeyFile = secret "service/wireguard/altair";

      peers = [
        {
          # Nova
          publicKey = keys.wireguard-nova;
          allowedIPs = [ "${hosts.nova}/32" ];
        }
        {
          # Luna
          publicKey = keys.wireguard-luna;
          allowedIPs = [ "${hosts.luna}/32" ];
        }
        {
          # Astra
          publicKey = keys.wireguard-astra;
          allowedIPs = [ "${hosts.astra}/32" ];
        }
      ];
    };
  };
}
