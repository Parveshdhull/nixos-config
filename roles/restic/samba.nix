{
  pkgs,
  lib,
  config,
  secrets,
  ...
}:

let
  makePrivateShare = path: {
    name = builtins.baseNameOf path;
    value = {
      inherit path;
      "browseable" = "no";
      "writeable" = "yes";
      "valid users" = [ "monu" ];
      "guest ok" = "no";
      "force user" = "monu";
    };
  };

  shares = {
    private = [ "/mnt/storagebox-${config.networking.hostName}/repositories/" ];
  };

in
{
  environment.systemPackages = with pkgs; [ samba ];

  services.samba = {
    enable = true;
    settings = {
      "global" = {
        "netbios name" = config.networking.hostName;
        "name resolve order" = "bcast host";
        "load printers" = false;
        "printcap name" = "/dev/null";
        "guest account" = "nobody";
        "map to guest" = "Bad User";
        "bind interfaces only" = true;
        "smb ports" = "${toString (import "${secrets}/config/ports.nix").samba}";
      };
    } // lib.listToAttrs (map makePrivateShare shares.private);
  };
}
