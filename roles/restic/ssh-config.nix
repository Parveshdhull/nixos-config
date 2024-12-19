{ pkgs, config, ... }:
let
  inherit (import ../../secrets/config) storagebox-user;
in
{
  programs.ssh = {
    extraConfig = ''
      Host storagebox
         HostName ${storagebox-user}.your-storagebox.de
         User ${storagebox-user}
         Port 23
         Identityfile /mnt/secrets/keys/storagebox
    '';
    knownHosts = {
      "${storagebox-user}.your-storagebox.de".publicKey = (import ../../secrets/keys).storagebox;
    };
  };
}
