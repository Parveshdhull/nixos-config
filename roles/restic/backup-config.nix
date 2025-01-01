# Define the makeBackup function
{
  pkgs,
  secret,
  secrets,
}:
let
  emailRecipient = (import "${secrets}/config").email-recipient;
in
{
  makeBackup =
    {
      repository,
      name,
      time,
      paths,
      passwordFile ? secret "service/restic/pass",
      rcloneConfigFile ? null,
    }:
    {
      inherit passwordFile;
      inherit paths;
      inherit repository;
      inherit rcloneConfigFile;
      user = "monu";
      initialize = true;
      extraBackupArgs = [ "--tag=${name}" ];
      pruneOpts = [
        "--keep-daily 7"
        "--keep-weekly 3"
        "--keep-monthly 12"
        "--keep-yearly 3"
      ];
      timerConfig = {
        OnCalendar = time;
        Persistent = true;
      };
      backupPrepareCommand = "${pkgs.restic}/bin/restic unlock --repo ${repository} --password-file ${passwordFile}";
      backupCleanupCommand = "/run/current-system/sw/bin/bash /etc/nebula/scripts/check-restic-backup ${repository} ${passwordFile} ${emailRecipient}";
    };
}
