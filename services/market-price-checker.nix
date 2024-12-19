{ pkgs, ... }:

{
  age.secrets = {
    "service/market-price-checker/assets" = {
      file = ../secrets/agenix/service/market-price-checker/assets.age;
      mode = "644";
    };
  };

  environment.systemPackages = with pkgs; [ jq ];

  systemd.services.market-price-checker = {
    description = "Market Price Checker Service";
    after = [ "initial-setup.service" ];
    path = [
      pkgs.bc
      pkgs.jq
      pkgs.curl
      pkgs.unstable.signal-cli
    ];
    onFailure = [ "service-failure-notification.service" ];
    serviceConfig = {
      ExecStart = "/run/current-system/sw/bin/bash /home/monu/bin/market-price-checker";
      User = "monu";
      StandardOutput = "journal";
      StandardError = "inherit";
    };
    wantedBy = [ "multi-user.target" ];
  };

  # Timer for Market Price Checker
  systemd.timers.market-price-checker = {
    description = "Run Market Price Checker Every Hour";
    timerConfig = {
      OnCalendar = "hourly";
      Unit = "market-price-checker.service";
    };
    wantedBy = [ "timers.target" ];
  };
}
