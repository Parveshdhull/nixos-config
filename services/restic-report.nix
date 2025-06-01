{ pkgs, ... }:

{
  # Restic report Service
  systemd.services.restic-report = {
    description = "Restic report Service";
    after = [
      "initial-setup.service"
      "network-online.target"
      "time-sync.target"
    ];
    requires = [
      "initial-setup.service"
      "network-online.target"
      "time-sync.target"
    ];
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
    wantedBy = [ "multi-user.target" ];
  };

  # Timer for Restic report Service
  systemd.timers.restic-report = {
    description = "Run Restic report service Every day at 13:30";
    timerConfig = {
      OnCalendar = "13:30";
      Persistent = true;
      Unit = "restic-report.service";
    };
    wantedBy = [ "timers.target" ];
  };
}
