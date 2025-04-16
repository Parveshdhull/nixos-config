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
    listenPort = ports.homepage-dashboard;
    services = [
      {
        "Self Hosted" = [
          {
            "Syncthing" = {
              href = "http://${hostName}.cosmos.vpn:${toString ports.syncthing}";
            };
          }
          {
            "Paperless" = {
              href = "http://luna.cosmos.vpn:${toString ports.paperless}";
            };
          }
          {
            "Immich" = {
              href = "http://luna.cosmos.vpn:${toString ports.immich}";
            };
          }
          {
            "Calibre" = {
              href = "http://luna.cosmos.vpn:${toString ports.calibre-web}";
            };
          }
          {
            "Audiobookshelf" = {
              href = "http://luna.cosmos.vpn:${toString ports.audiobookshelf}";
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
