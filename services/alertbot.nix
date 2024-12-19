{ pkgs, ... }:

{
  # Alert Bot Service
  systemd.services.alertbot = {
    description = "Alert Bot Service";
    after = [ "initial-setup.service" ];
    path = [ pkgs.unstable.signal-cli ];
    onFailure = [ "service-failure-notification.service" ];
    serviceConfig = {
      ExecStart = "/run/current-system/sw/bin/python /home/monu/bin/alertbot -r /mnt/data/nebula/sync/sync-all/notes/pinned/reminders -m signal";
      User = "monu";
      StandardOutput = "journal";
      StandardError = "inherit";
    };
    wantedBy = [ "multi-user.target" ];
  };

  # Timer for Alert Bot
  systemd.timers.alertbot = {
    description = "Run Alert Bot Every Minute";
    timerConfig = {
      OnUnitActiveSec = "1m";
      Unit = "alertbot.service";
    };
    wantedBy = [ "timers.target" ];
  };
}
