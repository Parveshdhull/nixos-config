{
  lib,
  pkgs,
  config,
  secrets,
  ...
}:
{
  services.openssh = {
    enable = true;
    ports = [ (import "${secrets}/config/ports.nix").openssh ];
    openFirewall = false;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = lib.mkForce "no";
      AllowUsers = [ "monu" ];
    };
  };
}
