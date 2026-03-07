{
  pkgs,
  lib,
  config,
  secrets,
  ...
}:

let
  inherit (config.networking) hostName;
  hosts = import "${secrets}/config/hosts.nix";

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
    nmbd.enable = lib.mkForce false;
    settings = {
      "global" = {
        "netbios name" = hostName;
        "name resolve order" = "bcast host";
        "load printers" = false;
        "printcap name" = "/dev/null";
        "guest account" = "nobody";
        "map to guest" = "Bad User";
        "interfaces" = "lo ${hosts.${hostName}}/24";
        "bind interfaces only" = true;
        "smb ports" = "${toString (import "${secrets}/config/ports.nix").PORT_SAMBA}";
      };
    }
    // lib.listToAttrs (map makePrivateShare shares.private);
  };
}
