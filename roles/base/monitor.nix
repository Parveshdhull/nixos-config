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
    let
      agentSecrets = {
        "service/beszel/agent" = {
          file = "${secrets}/agenix/service/beszel/agent.age";
        };
      };
    in
    if config.networking.hostName == "luna" then
      agentSecrets
      // {
        "service/beszel/hub" = {
          file = "${secrets}/agenix/service/beszel/hub.age";
        };
      }
    else
      agentSecrets;

  environment.systemPackages = with pkgs; [
    lm_sensors
    unstable.witr
  ];

  services.beszel.agent = {
    enable = true;
    smartmon.enable = true;
    environmentFile = secret-path "service/beszel/agent";
  };

  services.beszel.hub = {
    enable = hostName == "luna";
    port = ports.PORT_BESZEL;
    host = hosts.luna;
    environmentFile = secret-path "service/beszel/hub";
  };
}
