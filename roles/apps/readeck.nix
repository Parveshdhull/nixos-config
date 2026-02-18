{
  lib,
  pkgs,
  secret-path,
  secrets,
  ...
}:
{
  age.secrets = {
    "service/readeck/env" = {
      file = "${secrets}/agenix/service/readeck/env.age";
      owner = "readeck";
    };
  };

  services.readeck = {
    enable = true;
    environmentFile = secret-path "service/readeck/env";
    settings.server = {
      host = (import "${secrets}/config/hosts.nix").luna;
      port = (import "${secrets}/config/ports.nix").PORT_READECK;
    };
  };
}
