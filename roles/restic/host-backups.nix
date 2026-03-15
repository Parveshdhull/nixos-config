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
    {
      name,
      repository,
      time,
    }:
    makeBackup {
      inherit name;
      inherit repository;
      inherit time;
      paths = [ "/mnt/data/nebula/" ];
    };

  lunaBackup =
    {
      name,
      repository,
      time,
    }:
    makeBackup {
      inherit name;
      inherit repository;
      inherit time;
      paths = [
        "/mnt/data/apps"
        "/var/lib"
      ];
    };

  storageConfig = import ./storage-config.nix { inherit config; };

  hostBackups = {
    "luna" = {
      "storagebox-altair" = lunaBackup {
        name = "storagebox-altair";
        repository = storageConfig.storagebox-altair;
        time = "12:00";
      };
      "storagebox-luna" = lunaBackup {
        name = "storagebox-luna";
        repository = storageConfig.storagebox-luna;
        time = "13:00";
      };
      "storagebox-nova" = lunaBackup {
        name = "storagebox-nova";
        repository = storageConfig.storagebox-nova;
        time = "14:00";
      };
    };
    "nova" = {
      "storagebox-altair" = novaBackup {
        name = "storagebox-altair";
        repository = storageConfig.storagebox-altair;
        time = "13:00";
      };
      "storagebox-luna" = novaBackup {
        name = "storagebox-luna";
        repository = storageConfig.storagebox-luna;
        time = "13:30";
      };
      "storagebox-nova" = novaBackup {
        name = "storagebox-nova";
        repository = storageConfig.storagebox-nova;
        time = "12:00";
      };
      "mega" = makeBackup {
        repository = storageConfig.storagebox-mega;
        name = "mega";
        time = "12:30";
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
