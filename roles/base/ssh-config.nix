{
  pkgs,
  config,
  secrets,
  ...
}:
let
  inherit (import "${secrets}/config") storagebox-user;
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

      Host storagebox
        HostName ${storagebox-user}.your-storagebox.de
        User ${storagebox-user}
        Port 23
        Identityfile /mnt/secrets/keys/${config.networking.hostName}
    '';
    knownHosts = {
      "${storagebox-user}.your-storagebox.de".publicKey = (import "${secrets}/keys").storagebox;
    };
  };
}
