{
  lib,
  pkgs,
  secret,
  secrets,
  ...
}:
let
  myEmailAddress = (import "${secrets}/config").my-email-address;
in
{
  age.secrets = {
    "service/msmtp/credential" = {
      file = "${secrets}/agenix/service/msmtp/credential.age";
      mode = "644";
    };
  };

  programs.msmtp = {
    enable = true;
    accounts.default = {
      auth = "on";
      tls = "on";
      from = myEmailAddress;
      user = myEmailAddress;
      host = "smtp.gmail.com";
      port = "587";
      passwordeval = "cat ${secret "service/msmtp/credential"}";
      tls_trust_file = "/etc/ssl/certs/ca-certificates.crt";
    };
  };

  environment.systemPackages = with pkgs.unstable; [ signal-cli ];
}
