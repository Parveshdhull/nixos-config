{
  pkgs,
  config,
  secrets,
  ...
}:
let
  inherit (import "${secrets}/config") storagebox-user;
  opensshPort = toString (import "${secrets}/config/ports.nix").openssh;
in
{
  programs.ssh = {
    extraConfig = ''
      Host nova
        HostName nova.cosmos.vpn
        User monu
        Port ${opensshPort}
        IdentityFile /mnt/secrets/keys/sirius

      Host luna
        HostName luna.cosmos.vpn
        User monu
        Port ${opensshPort}
        IdentityFile /mnt/secrets/keys/sirius

      Host altair
        HostName altair.cosmos.vpn
        User monu
        Port ${opensshPort}
        IdentityFile /mnt/secrets/keys/sirius

      Host github.com
        User git
        IdentityFile /mnt/secrets/keys/sirius

      Host storagebox
        HostName ${storagebox-user}.your-storagebox.de
        User ${storagebox-user}
        Port 23
        Identityfile /mnt/secrets/keys/storagebox
    '';
    knownHosts = {
      "${storagebox-user}.your-storagebox.de".publicKey = (import "${secrets}/keys").storagebox;
    };
  };
}
