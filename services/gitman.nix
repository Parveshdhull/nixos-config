{ pkgs, secrets, ... }:

{
  systemd.services.gitman = {
    description = "Automated git commits";
    path = [ pkgs.git ];
    after = [ "initial-setup.service" ];
    onFailure = [ "service-failure-notification.service" ];
    serviceConfig = {
      ExecStart = "${pkgs.bash}/bin/bash  /home/monu/bin/gitman";
      User = "monu";
      StandardOutput = "journal";
      StandardError = "inherit";
    };
    wantedBy = [ "multi-user.target" ];
  };

  # Timer for Gitman
  systemd.timers.gitman = {
    description = "Run Gitman Every Hour";
    timerConfig = {
      OnCalendar = "hourly";
      Unit = "gitman.service";
    };
    wantedBy = [ "timers.target" ];
  };
}
