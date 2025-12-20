{ pkgs, secrets, ... }:

{
  environment.etc = {
    "nebula/scripts/signal-cli-monitor".text = builtins.readFile ./scripts/signal-cli-monitor;
  };

  systemd.services.signal-cli-monitor = {
    description = "Signal CLI Monitor Service";
    path = [
      pkgs.msmtp
      pkgs.signal-cli
    ];
    after = [ "initial-setup.service" ];
    environment = {
      MY_EMAIL_ADDRESS = (import "${secrets}/config").my-email-address;
    };
    onFailure = [ "service-failure-notification.service" ];
    serviceConfig = {
      ExecStart = "${pkgs.bash}/bin/bash  /etc/nebula/scripts/signal-cli-monitor";
      User = "monu";
      StandardOutput = "journal";
      StandardError = "inherit";
    };
    wantedBy = [ "multi-user.target" ];
  };

  # Timer for Signal CLI Monitor
  systemd.timers.signal-cli-monitor = {
    description = "Run Signal CLI Monitor Every Hour";
    timerConfig = {
      OnCalendar = "hourly";
      Unit = "signal-cli-monitor.service";
    };
    wantedBy = [ "timers.target" ];
  };
}
