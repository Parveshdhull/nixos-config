{
  pkgs,
  config,
  secrets,
  ...
}:
let
  opensshPort = toString (import "${secrets}/config/ports.nix").PORT_OPENSSH;
in
{
  programs.ssh = {
    extraConfig = ''
      Host nova
        HostName nova.cosmos.vpn
        User monu
        Port ${opensshPort}

      Host luna
        HostName luna.cosmos.vpn
        User monu
        Port ${opensshPort}

      Host altair
        HostName altair.cosmos.vpn
        User monu
        Port ${opensshPort}

      Host localhost
        HostName localhost
        User orion
        Port ${opensshPort}

      Host lyra
        HostName lyra.cosmos.vpn
        User monu
        Port 22

      Host github.com
        User git
    '';
  };
}
