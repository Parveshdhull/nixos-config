# Define the makeBackup function
{
  pkgs,
  secret-path,
  secrets,
}:
let
  myEmailAddress = (import "${secrets}/config").my-email-address;
in
{
  makeBackup =
    {
      repository,
      name,
      time,
      paths,
      passwordFile ? secret-path "service/restic/pass",
      rcloneConfigFile ? null,
    }:
    {
      inherit passwordFile;
      inherit paths;
      inherit repository;
      rcloneConfigFile = secret-path "service/rclone/conf";
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
        RandomizedDelaySec = "5min"; # delay to avoid running before system time is correctly synced at boot
      };
      backupPrepareCommand = "${pkgs.restic}/bin/restic unlock --repo ${repository} --password-file ${passwordFile}";
      backupCleanupCommand = "${pkgs.bash}/bin/bash /etc/nebula/scripts/check-restic-backup ${repository} ${passwordFile} ${myEmailAddress}";
    };
}
