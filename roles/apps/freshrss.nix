{
  lib,
  pkgs,
  secret-path,
  secrets,
  ...
}:
{
  age.secrets = {
    "service/freshrss/pass" = {
      file = "${secrets}/agenix/service/freshrss/pass.age";
      mode = "644";
    };
  };

  services.freshrss = {
    enable = true;
    defaultUser = "monu";
    baseUrl = (import "${secrets}/config/hosts.nix").luna;
    dataDir = "/mnt/data/apps/freshrss";
    passwordFile = secret-path "service/freshrss/pass";
  };
}
