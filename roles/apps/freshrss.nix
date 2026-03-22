{
  lib,
  pkgs,
  secret-path,
  secrets,
  ...
}:
{
  age.secrets = {
    "service/freshrss/pass" = {
      file = "${secrets}/agenix/service/freshrss/pass.age";
      owner = "freshrss";
    };
  };

  services.freshrss = {
    enable = true;
    defaultUser = "monu";
    baseUrl = "http://rss.luna.cosmos.vpn";
    dataDir = "/mnt/data/apps/freshrss";
    passwordFile = secret-path "service/freshrss/pass";
  };

  # Override freshrss-updater timer
  systemd.timers."freshrss-updater" = {
    timerConfig = {
      OnCalendar = lib.mkForce "hourly";
      RandomizedDelaySec = "5m";
      Persistent = true;
    };
  };
}
