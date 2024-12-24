{ pkgs, secrets, ... }:

{
  environment.etc = {
    "nebula/scripts/check-restic-backups".text = builtins.readFile ./scripts/check-restic-backups;
  };

  systemd.services.check-restic-backups = {
    description = "Check Restic Backups";
    path = [
      pkgs.hostname
      pkgs.msmtp
      pkgs.openssh
      pkgs.restic
      pkgs.rclone
    ];
    after = [ "initial-setup.service" ];
    environment = {
      EMAIL_RECIPIENT = (import "${secrets}/config").email-recipient;
    };
    onFailure = [ "service-failure-notification.service" ];
    serviceConfig = {
      ExecStart = "/run/current-system/sw/bin/bash  /etc/nebula/scripts/check-restic-backups";
      User = "monu";
      StandardOutput = "journal";
      StandardError = "inherit";
    };
    wantedBy = [ "multi-user.target" ];
  };

  # Timer for Check Restic Backups
  systemd.timers.check-restic-backups = {
    description = "Run Check Restic Backups daily at 5 PM";
    timerConfig = {
      OnCalendar = "17:00";
      Persistent = true;
      Unit = "check-restic-backups.service";
    };
    wantedBy = [ "timers.target" ];
  };
}
