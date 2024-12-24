{ pkgs, secrets, ... }:

{
  environment.etc = {
    "nebula/scripts/service-failure-notification".text =
      builtins.readFile ./scripts/service-failure-notification;
  };

  systemd.services.service-failure-notification = {
    description = "Send notification for service failure";
    path = [
      pkgs.msmtp
      pkgs.gawk
    ];
    environment = {
      EMAIL_RECIPIENT = (import "${secrets}/config").email-recipient;
    };
    serviceConfig = {
      ExecStart = "/run/current-system/sw/bin/bash /etc/nebula/scripts/service-failure-notification";
    };
    wantedBy = [ "multi-user.target" ];
  };
}
