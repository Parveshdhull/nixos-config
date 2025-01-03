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
      MY_EMAIL_ADDRESS = (import "${secrets}/config").my-email-address;
    };
    serviceConfig = {
      ExecStart = "${pkgs.bash}/bin/bash /etc/nebula/scripts/service-failure-notification";
    };
    wantedBy = [ "multi-user.target" ];
  };
}
