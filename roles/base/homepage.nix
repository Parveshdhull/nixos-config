{
  config,
  lib,
  pkgs,
  secret,
  secrets,
  ...
}:
let
  inherit (config.networking) hostName;
  ports = import "${secrets}/config/ports.nix";
in
{
  services.homepage-dashboard = {
    enable = true;
    listenPort = ports.PORT_HOMEPAGE_DASHBOARD;
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
