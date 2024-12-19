{
  pkgs,
  config,
  secret,
  secrets,
  ...
}:

let
  users = import "${secrets}/keys/users";
  sshKeys = [
    users.orion
    users.sirius
  ];
in
{
  age.secrets."hosts/users/monu/pass-hash" = {
    file = "${secrets}/agenix/hosts/users/monu/pass-hash.age";
  };

  # Give extra permissions with Nix
  nix.settings.trusted-users = [ "monu" ];

  users = {
    groups.monu = {
      gid = 1000;
      name = "monu";
    };

    mutableUsers = false; # Set mutableUsers to false to ensure hashed passwords function correctly

    users.monu = {
      uid = 1000;
      createHome = true;
      isNormalUser = true;
      useDefaultShell = true;
      group = "monu";
      hashedPasswordFile = "${secret "hosts/users/monu/pass-hash"}";
      extraGroups = [
        "wheel"
        "networkmanager"
      ];
      openssh.authorizedKeys.keys = sshKeys;
    };
  };

  security.sudo.wheelNeedsPassword = false; # Todo - remove once migration to pass
}
