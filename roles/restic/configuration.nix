{
  pkgs,
  config,
  lib,
  secret,
  secrets,
  ...
}:

let
  hostBackups = import ./host-backups.nix {
    inherit pkgs;
    inherit config;
    inherit secret;
    inherit secrets;
  };
  currentBackups = hostBackups.currentHostBackups;

  backupServices = lib.mapAttrsToList (backupName: backupConfig: {
    name = "restic-backups-${backupName}";
    value = {
      serviceConfig = {
        TimeoutStopSec = "1200"; # Increase timeout to 20 Mintute for cleanup script
      };
    };
  }) currentBackups;
in
{
  imports = [
    ./age-secrets.nix
  ];

  environment.etc = {
    "nebula/scripts/check-restic-backup".text =
      builtins.readFile ../../services/scripts/check-restic-backup;
  };

  users.users.monu.packages = [ pkgs.restic ];

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
