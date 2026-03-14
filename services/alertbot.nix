{ pkgs, secrets, ... }:

{
  imports = [
    ../roles/apps/signal-cli.nix
    ./signal-cli-monitor.nix
  ];

  # Alert Bot Service
  systemd.services.alertbot = {
    description = "Alert Bot Service";
    after = [ "initial-setup.service" ];
    path = [
      pkgs.signal-cli
      pkgs.msmtp
    ];
    onFailure = [ "service-failure-notification.service" ];
    environment = {
      MY_EMAIL_ADDRESS = (import "${secrets}/config").my-email-address;
    };
    serviceConfig = {
      ExecStart = "/run/current-system/sw/bin/python /home/monu/bin/alertbot -r /mnt/data/nebula/sync/sync-box/notes/pinned/reminders -m signal";
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
