{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./disk-config.nix
    ../../roles/apps
    ../../roles/base
    ../../roles/restic
    ../../roles/ssh.nix
    ../../roles/systemd-boot.nix
    ../../roles/wireguard-client.nix
  ];

  fileSystems."/mnt/storagebox-luna" = {
    device = "/dev/disk/by-label/storagebox-luna";
  };

  # Don't suspend on lid close
  services.logind.settings.Login.HandleLidSwitch = "ignore";
  services.logind.settings.Login.HandleLidSwitchExternalPower = "ignore";
}
