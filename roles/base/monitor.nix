{
  lib,
  pkgs,
  config,
  secrets,
  secret-path,
  ...
}:
let
  inherit (config.networking) hostName;
  hosts = import "${secrets}/config/hosts.nix";
  ports = import "${secrets}/config/ports.nix";
in
{
  age.secrets =
    if hostName == "luna" then
      {
        "service/beszel/hub" = {
          file = "${secrets}/agenix/service/beszel/hub.age";
        };
      }
    else
      { };

  environment.systemPackages = with pkgs; [
    lm_sensors
    unstable.witr
  ];

  services.beszel.agent = {
    enable = hostName == "luna";
    smartmon.enable = true;
    environmentFile = secret-path "service/beszel/hub";
  };

  services.beszel.hub = {
    enable = hostName == "luna";
    port = ports.PORT_BESZEL;
    host = hosts.luna;
    environmentFile = secret-path "service/beszel/hub";
  };
}
