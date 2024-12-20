{
  pkgs,
  config,
  secret,
  ...
}:

let
  inherit
    (import ./backup-config.nix {
      inherit secret;
      inherit pkgs;
    })
    makeBackup
    ;
  storageConfig = import ./storage-config.nix { inherit config; };

  hostBackups = {
    "nova" = {
      "nebula" = makeBackup {
        repository = storageConfig.storagebox;
        name = "nebula";
        time = "14:00";
        paths = [ "/mnt/data/nebula/" ];
      };
      "nebula-local" = makeBackup {
        repository = storageConfig.storagebox-nova;
        name = "nebula";
        time = "14:00";
        paths = [ "/mnt/data/nebula/" ];
      };
      "mega" = makeBackup {
        repository = storageConfig.storagebox-mega;
        name = "mega";
        time = "14:00";
        paths = [
          "/mnt/data/nebula/important/creds"
          "/mnt/data/nebula/sync/sync-box/creds/"
        ];
        passwordFile = secret "service/restic/pass-mega";
        rcloneConfigFile = secret "service/rclone/conf";
      };
    };
    "luna" = {
      "immich" = makeBackup {
        repository = storageConfig.storagebox;
        name = "immich";
        time = "00:00";
        paths = [ "/mnt/data/immich" ];
      };
      "immich-local" = makeBackup {
        repository = storageConfig.storagebox-luna;
        name = "immich";
        time = "00:00";
        paths = [ "/mnt/data/immich" ];
      };
      "paperless" = makeBackup {
        repository = storageConfig.storagebox;
        name = "paperless";
        time = "01:00";
        paths = [ "/mnt/data/paperless" ];
      };
      "paperless-local" = makeBackup {
        repository = storageConfig.storagebox-luna;
        name = "paperless";
        time = "01:00";
        paths = [ "/mnt/data/paperless" ];
      };
      "calibre" = makeBackup {
        repository = storageConfig.storagebox;
        name = "calibre";
        time = "02:00";
        paths = [ "/mnt/data/calibre" ];
      };
      "calibre-local" = makeBackup {
        repository = storageConfig.storagebox-luna;
        name = "calibre";
        time = "02:00";
        paths = [ "/mnt/data/calibre" ];
      };
      "calibre-web" = makeBackup {
        repository = storageConfig.storagebox;
        name = "calibre-web";
        time = "03:00";
        paths = [ "/var/lib/calibre-web" ];
      };
      "calibre-web-local" = makeBackup {
        repository = storageConfig.storagebox-luna;
        name = "calibre-web";
        time = "03:00";
        paths = [ "/var/lib/calibre-web" ];
      };
      "audiobookshelf" = makeBackup {
        repository = storageConfig.storagebox;
        name = "audiobookshelf";
        time = "04:00";
        paths = [ "/var/lib/audiobookshelf" ];
      };
      "audiobookshelf-local" = makeBackup {
        repository = storageConfig.storagebox-luna;
        name = "audiobookshelf";
        time = "04:00";
        paths = [ "/var/lib/audiobookshelf" ];
      };
    };
  };

in
{
  currentHostBackups = hostBackups.${config.networking.hostName} or { };
}
