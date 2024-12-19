{
  lib,
  pkgs,
  secret,
  ...
}:

{
  age.secrets = {
    "service/msmtp/credential" = {
      file = ../secrets/agenix/service/msmtp/credential.age;
      mode = "644";
    };
  };

  programs.msmtp = {
    enable = true;
    accounts.default = {
      auth = "on";
      tls = "on";
      from = "git.hrca@gmail.com";
      user = "git.hrca@gmail.com";
      host = "smtp.gmail.com";
      port = "587";
      passwordeval = "cat ${secret "service/msmtp/credential"}";
      tls_trust_file = "/etc/ssl/certs/ca-certificates.crt";
    };
  };

  environment.systemPackages = with pkgs.unstable; [ signal-cli ];
}
