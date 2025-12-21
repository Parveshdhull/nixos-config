{
  pkgs,
  config,
  lib,
  secret-path,
  secrets,
  ...
}:

let
  hostBackups = import ./host-backups.nix {
    inherit pkgs;
    inherit config;
    inherit secret-path;
    inherit secrets;
  };
  currentBackups = hostBackups.currentHostBackups;

  backupServices = lib.mapAttrsToList (backupName: backupConfig: {
    name = "restic-backups-${backupName}";
    value = {
      serviceConfig = {
        TimeoutStopSec = "10800"; # Increase timeout to 3 Hours for cleanup script
        AmbientCapabilities = [ "CAP_DAC_READ_SEARCH" ];
      };
    };
  }) currentBackups;
in
{
  imports = [
    ./age-secrets.nix
    ./samba.nix
  ];

  environment.etc = {
    "nebula/scripts/check-restic-backup".text =
      builtins.readFile ../../services/scripts/check-restic-backup;
  };

  users.users.monu.packages = [
    pkgs.rclone
    pkgs.restic
  ];

  users.users.restic = {
    isSystemUser = true;
    group = "restic";
  };
  users.groups.restic = {};

  services.restic.backups = currentBackups;

  # Dynamically update systemd services for each backup and increase timeout
  systemd.services = lib.foldl' (
    acc: service:
    acc
    // {
      "${service.name}" = service.value;
    }
  ) { } backupServices;
}
