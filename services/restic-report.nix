{ pkgs, ... }:

{
  # Restic report Service
  systemd.services.restic-report = {
    description = "Restic report Service";
    after = [ "initial-setup.service" ];
    path = [
      pkgs.restic
      pkgs.rclone
      pkgs.gawk
      pkgs.openssh
    ];
    onFailure = [ "service-failure-notification.service" ];
    serviceConfig = {
      ExecStart = "${pkgs.bash}/bin/bash /home/monu/bin/restic-report";
      User = "monu";
      StandardOutput = "journal";
      StandardError = "inherit";
    };
    wantedBy = [ "multi-user.target" ];
  };

  # Timer for Restic report Service
  systemd.timers.restic-report = {
    description = "Run Alert Bot Every Minute";
    timerConfig = {
      OnCalendar = "17:00";
      Persistent = true;
      Unit = "restic-report.service";
    };
    wantedBy = [ "timers.target" ];
  };
}
