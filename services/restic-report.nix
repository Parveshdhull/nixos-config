{ pkgs, ... }:

{
  # Restic report Service
  systemd.services.restic-report = {
    description = "Restic report Service";
    path = [
      pkgs.conky
      pkgs.gawk
      pkgs.openssh
      pkgs.rclone
      pkgs.restic
    ];
    environment = {
      DISPLAY = ":0";
    };
    onFailure = [ "service-failure-notification.service" ];
    serviceConfig = {
      ExecStart = "${pkgs.bash}/bin/bash /home/monu/bin/restic-report";
      User = "monu";
      StandardOutput = "journal";
      StandardError = "inherit";
    };
  };

  # Timer for Restic report Service
  systemd.timers.restic-report = {
    description = "Run Restic report service Every day at 13:30";
    timerConfig = {
      OnCalendar = "13:30";
      Unit = "restic-report.service";
    };
    wantedBy = [ "timers.target" ];
  };
}
