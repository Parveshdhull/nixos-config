{
  lib,
  pkgs,
  secret-path,
  secrets,
  ...
}:
let
  config = import "${secrets}/config";
in
{
  services.seafile = {
    enable = true;
    user = "monu";
    dataDir = "/mnt/data/apps/seafile";
    adminEmail = config.my-email-address;
    initialAdminPassword = config.seafile-initial-password;
    gc.enable = true;
    ccnetSettings.General.SERVICE_URL = "http://seafile.luna.cosmos.vpn";
    seafileSettings.fileserver.host = "unix:/run/seafile/server.sock";
    seahubExtraConf = ''ALLOWED_HOSTS = ["seafile.luna.cosmos.vpn"]'';
  };

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;

    virtualHosts."seafile.luna.cosmos.vpn" = {
      enableACME = false;
      forceSSL = false;

      locations."/" = {
        proxyPass = "http://unix:/run/seahub/gunicorn.sock";
      };

      locations."/seafhttp" = {
        proxyPass = "http://unix:/run/seafile/server.sock";
        extraConfig = ''rewrite ^/seafhttp(.*)$ $1 break;'';
      };
    };
  };
}
