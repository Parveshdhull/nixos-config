{
  config,
  lib,
  pkgs,
  secrets,
  ...
}:
let
  keys = import "${secrets}/keys";
in
{
  options.syncthing = {
    hosts = lib.mkOption {
      default = {
        nova = {
          # desktop
          id = keys.syncthing-nova;
          addresses = [ "tcp://nova.cosmos.vpn:22000" ];
          autoAcceptFolders = true;
        };
        altair = {
          # server
          id = keys.syncthing-altair;
          addresses = [ "tcp://altair.cosmos.vpn:22000" ];
          autoAcceptFolders = true;
        };
        luna = {
          # laptop
          id = keys.syncthing-luna;
          addresses = [ "tcp://luna.cosmos.vpn:22000" ];
          autoAcceptFolders = true;
        };
        astra = {
          # Android
          id = keys.syncthing-astra;
          addresses = [ "tcp://astra.cosmos.vpn:22000" ];
          autoAcceptFolders = true;
        };
      };
    };
  };

  config =
    let
      inherit (config.networking) hostName;
      notThisHost = h: h != hostName;
      otherHosts = builtins.filter notThisHost (lib.attrNames config.syncthing.hosts);
      inherit (config) services;
      hosts = import "${secrets}/config/hosts.nix";
      port = toString (import "${secrets}/config/ports.nix").PORT_SYNCTHING;

      guiAddress = "${hosts.${hostName}}:${port}";

      allFolders = {
        "/mnt/data/nebula/sync/sync-all" = {
          id = "sync-all";
          type = "sendreceive";
          devices = otherHosts;
        };
        "/mnt/data/nebula/sync/sync-box" = {
          id = "sync-box";
          type = "sendreceive";
          devices = builtins.filter (h: h != "altair") otherHosts;
        };
      };

      folders =
        if hostName != "altair" then
          allFolders
        else
          { "/mnt/data/nebula/sync/sync-all" = allFolders."/mnt/data/nebula/sync/sync-all"; };

    in
    {
      # Service
      systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true";
      services.syncthing = {
        enable = true;
        user = "monu";
        group = "monu";
        overrideDevices = true;
        overrideFolders = true;
        configDir = "/home/monu/.config/syncthing/config";
        dataDir = "/home/monu/.config/syncthing";
        inherit guiAddress;

        # Use when syncing gets stuck.
        #extraFlags = ["--reset-deltas"];

        settings = {
          gui = {
            user = "monu";
            password = (import "${secrets}/config").syncthing-password;
          };
          devices = lib.filterAttrs (h: _: notThisHost h) config.syncthing.hosts;
          inherit folders;
        };
      };

      # Bump the inotify limit
      # https://docs.syncthing.net/users/faq.html#inotify-limits
      boot.kernel.sysctl = {
        "fs.inotify.max_user_watches" = "204800";
      };
    };
}
