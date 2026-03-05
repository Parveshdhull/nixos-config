{
  lib,
  pkgs,
  config,
  secrets,
  ...
}:
let
  inherit (config.networking) hostName;
  hosts = import "${secrets}/config/hosts.nix";
in
{
  services.openssh = {
    enable = true;
    ports = [ (import "${secrets}/config/ports.nix").PORT_OPENSSH ];
    openFirewall = false;
    listenAddresses = [
      {
        addr = "${hosts.${hostName}}";
      }
      {
        addr = "localhost";
      }
    ];
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = lib.mkForce "no";
      AllowUsers = [
        "monu"
        "orion"
      ];
    };
  };
}
