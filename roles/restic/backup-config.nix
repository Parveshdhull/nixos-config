# Define the makeBackup function
{ pkgs, secret }:
{
  makeBackup =
    {
      extraOptions ? [ ],
      repository,
      name,
      passwordFile ? secret "service/restic/pass",
      paths,
      time,
    }:
    {
      inherit extraOptions;
      inherit passwordFile;
      inherit paths;
      inherit repository;
      user = "monu";
      initialize = true;
      extraBackupArgs = [ "--tag=${name}" ];
      pruneOpts = [
        "--keep-daily 7"
        "--keep-weekly 3"
        "--keep-monthly 12"
        "--keep-yearly 3"
      ];
      runCheck = true;
      checkOpts = [ "--read-data-subset=1%" ];
      timerConfig = {
        OnCalendar = time;
        Persistent = true;
      };
      backupPrepareCommand = "${pkgs.restic}/bin/restic unlock --repo ${repository} --password-file ${passwordFile}";
    };
}
