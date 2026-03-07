{
  pkgs,
  config,
  secret-path,
  secrets,
  ...
}:

let
  inherit
    (import ./backup-config.nix {
      inherit pkgs;
      inherit secret-path;
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
      time = "13:05";
      paths = [
        "/mnt/data/apps"
        "/var/lib"
      ];
    };

  storageConfig = import ./storage-config.nix { inherit config; };

  hostBackups = {
    "luna" = {
      "storagebox-altair" = lunaBackup "storagebox-altair" storageConfig.storagebox-altair;
      "storagebox-luna" = lunaBackup "storagebox-luna" storageConfig.storagebox-luna;
      "storagebox-nova" = lunaBackup "storagebox-nova" storageConfig.storagebox-nova;
    };
    "nova" = {
      "storagebox-altair" = novaBackup "storagebox-altair" storageConfig.storagebox-altair;
      "storagebox-luna" = novaBackup "storagebox-luna" storageConfig.storagebox-luna;
      "storagebox-nova" = novaBackup "storagebox-nova" storageConfig.storagebox-nova;
      "mega" = makeBackup {
        repository = storageConfig.storagebox-mega;
        name = "mega";
        time = "13:00";
        paths = [
          "/mnt/data/nebula/important/creds"
          "/mnt/data/nebula/sync/sync-box/creds/"
        ];
        passwordFile = secret-path "service/restic/pass-mega";
      };
    };
  };

in
{
  currentHostBackups = hostBackups.${config.networking.hostName} or { };
}
