{
  pkgs,
  config,
  secret,
  secrets,
  ...
}:

let
  inherit
    (import ./backup-config.nix {
      inherit pkgs;
      inherit secret;
      inherit secrets;
    })
    makeBackup
    ;
  storageConfig = import ./storage-config.nix { inherit config; };

  hostBackups = {
    "nova" = {
      "storagebox" = makeBackup {
        repository = storageConfig.storagebox;
        name = "storagebox";
        time = "14:00";
        paths = [ "/mnt/data/nebula/" ];
      };
      "local" = makeBackup {
        repository = storageConfig.storagebox-nova;
        name = "local";
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
      "storagebox" = makeBackup {
        repository = storageConfig.storagebox;
        name = "storagebox";
        time = "12:00";
        paths = [
          "/mnt/data/calibre"
          "/mnt/data/immich"
          "/mnt/data/paperless"
          "/var/lib/audiobookshelf"
          "/var/lib/calibre-web"
        ];
      };
      "local" = makeBackup {
        repository = storageConfig.storagebox-luna;
        name = "local";
        time = "12:00";
        paths = [
          "/mnt/data/calibre"
          "/mnt/data/immich"
          "/mnt/data/paperless"
          "/var/lib/audiobookshelf"
          "/var/lib/calibre-web"
        ];
      };
    };
  };

in
{
  currentHostBackups = hostBackups.${config.networking.hostName} or { };
}
