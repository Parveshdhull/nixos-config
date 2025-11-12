{
  config,
  lib,
  pkgs,
  secrets,
  ...
}:
let
  inherit (config.networking) hostName;
  ports = import "${secrets}/config/ports.nix";
  hosts = import "${secrets}/config/hosts.nix";
  dashboard-port = ports.PORT_HOMEPAGE_DASHBOARD;
  dashboard-port-string = toString dashboard-port;
in
{
  services.homepage-dashboard = {
    enable = true;
    listenPort = dashboard-port;
    allowedHosts = "${hostName}.cosmos.vpn:${dashboard-port-string},${hosts.${hostName}}:${dashboard-port-string}";
    services = [
      {
        "Self Hosted" = [
          {
            "Syncthing" = {
              href = "http://${hostName}.cosmos.vpn:${toString ports.PORT_SYNCTHING}";
            };
          }
          {
            "Paperless" = {
              href = "http://luna.cosmos.vpn:${toString ports.PORT_PAPERLESS}";
            };
          }
          {
            "Immich" = {
              href = "http://luna.cosmos.vpn:${toString ports.PORT_IMMICH}";
            };
          }
          {
            "Calibre" = {
              href = "http://luna.cosmos.vpn:${toString ports.PORT_CALIBRE_WEB}";
            };
          }
          {
            "Audiobookshelf" = {
              href = "http://luna.cosmos.vpn:${toString ports.PORT_AUDIOBOOHSHELF}";
            };
          }
          {
            "FreshRSS" = {
              href = "http://luna.cosmos.vpn:${toString ports.PORT_FRESHRSS}";
            };
          }
          {
            "AdguardHome" = {
              href = "http://luna.cosmos.vpn:${toString ports.PORT_ADGUARD}";
            };
          }
          {
            "Seafile" = {
              href = "http://luna.cosmos.vpn:${toString ports.PORT_SEAFILE}";
            };
          }
        ];
      }
    ];
    widgets = [
      {
        resources = {
          cpu = true;
          memory = true;
          disk =
            if hostName == "nova" then
              [
                "/"
                "/mnt/data"
                "/mnt/storagebox-nova"
              ]
            else if hostName == "luna" then
              [
                "/"
                "/mnt/data"
                "/mnt/storagebox-luna"
              ]
            else
              [ "/" ];
        };
      }
    ];
  };
}
