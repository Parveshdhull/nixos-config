{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./disk-config.nix
    ../../roles/audiobookshelf.nix
    ../../roles/base.nix
    ../../roles/calibre.nix
    ../../roles/immich.nix
    ../../roles/paperless.nix
    ../../roles/janitor.nix
    ../../roles/restic/configuration.nix
    ../../roles/ssh.nix
    ../../roles/systemd-boot.nix
    ../../roles/wireguard-client.nix
  ];

  fileSystems."/mnt/storagebox-luna" = {
    device = "/dev/disk/by-label/storagebox-luna";
  };

  # Don't suspend on lid close
  services.logind.lidSwitch = "ignore";
  services.logind.lidSwitchExternalPower = "ignore";
}
