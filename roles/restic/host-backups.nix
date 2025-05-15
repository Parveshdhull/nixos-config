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

  novaBackup =
    name: repository:
    makeBackup {
      inherit name;
      inherit repository;
      time = "13:00";
      paths = [ "/mnt/data/nebula/" ];
    };

  lunaBackup =
    name: repository:
    makeBackup {
      inherit name;
      inherit repository;
      time = "13:30";
      paths = [
        "/mnt/data/apps"
        "/var/lib/audiobookshelf"
        "/var/lib/calibre-web"
      ];
    };

  storageConfig = import ./storage-config.nix { inherit config; };

  hostBackups = {
    "luna" = {
      "storagebox" = lunaBackup "storagebox" storageConfig.storagebox;
      "storagebox-nova" = lunaBackup "storagebox-nova" storageConfig.storagebox-nova;
      "storagebox-luna" = lunaBackup "storagebox-luna" storageConfig.storagebox-luna;
    };
    "nova" = {
      "storagebox" = novaBackup "storagebox" storageConfig.storagebox;
      "storagebox-nova" = novaBackup "storagebox-nova" storageConfig.storagebox-nova;
      "storagebox-luna" = novaBackup "storagebox-luna" storageConfig.storagebox-luna;
      "mega" = makeBackup {
        repository = storageConfig.storagebox-mega;
        name = "mega";
        time = "13:00";
        paths = [
          "/mnt/data/nebula/important/creds"
          "/mnt/data/nebula/sync/sync-box/creds/"
        ];
        passwordFile = secret "service/restic/pass-mega";
      };
    };
  };

in
{
  currentHostBackups = hostBackups.${config.networking.hostName} or { };
}
