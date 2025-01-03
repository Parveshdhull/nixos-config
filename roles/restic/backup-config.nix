# Define the makeBackup function
{
  pkgs,
  secret,
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
      backupCleanupCommand = "${pkgs.bash}/bin/bash /etc/nebula/scripts/check-restic-backup ${repository} ${passwordFile} ${myEmailAddress}";
    };
}
