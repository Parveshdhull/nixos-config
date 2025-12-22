{
  pkgs,
  config,
  secret-path,
  secrets,
  ...
}:

let
  users = import "${secrets}/keys/users";
  sshKeys = [ users.orion ];
in
{
  age.secrets."hosts/users/monu/pass-hash" = {
    file = "${secrets}/agenix/hosts/users/monu/pass-hash.age";
  };

  age.secrets."hosts/users/orion/pass-hash" = {
    file = "${secrets}/agenix/hosts/users/orion/pass-hash.age";
  };

  users = {
    groups = {
      monu = {
        gid = 1000;
        name = "monu";
      };
      orion = {
        gid = 1001;
        name = "orion";
      };
    };

    users = {
      monu = {
        uid = 1000;
        createHome = true;
        isNormalUser = true;
        useDefaultShell = true;
        group = "monu";
        hashedPasswordFile = "${secret-path "hosts/users/monu/pass-hash"}";
        extraGroups = [
          "networkmanager"
        ];
        openssh.authorizedKeys.keys = sshKeys;
      };

      orion = {
        uid = 1001;
        group = "monu";
        isNormalUser = true;
        hashedPasswordFile = "${secret-path "hosts/users/orion/pass-hash"}";
        extraGroups = [
          "wheel"
        ];
        openssh.authorizedKeys.keys = sshKeys;
      };
    };
    mutableUsers = false; # Set mutableUsers to false to ensure hashed passwords function correctly
  };

  # Make home readable to monu group(required for orion)
  systemd.tmpfiles.rules = [
    "d /home/monu 750 monu monu - -"
  ];

  # Give extra permissions with Nix
  nix.settings.trusted-users = [
    "monu"
    "orion"
  ];
}
