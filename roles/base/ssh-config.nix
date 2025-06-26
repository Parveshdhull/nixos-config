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

      Host mac
        HostName 192.168.1.9
        User parvesh_monu
        Port 22

      Host luna
        HostName luna.cosmos.vpn
        User monu
        Port ${opensshPort}

      Host altair
        HostName altair.cosmos.vpn
        User monu
        Port ${opensshPort}

      Host github.com
        User git
    '';
  };
}
