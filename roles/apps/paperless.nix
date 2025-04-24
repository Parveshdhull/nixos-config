{
  lib,
  pkgs,
  secret,
  secrets,
  ...
}:

{
  age.secrets = {
    "service/paperless/pass" = {
      file = "${secrets}/agenix/service/paperless/pass.age";
    };
  };

  services.paperless = {
    address = (import "${secrets}/config/hosts.nix").luna;
    enable = true;
    passwordFile = secret "service/paperless/pass";
    port = (import "${secrets}/config/ports.nix").paperless;
    dataDir = "/mnt/data/apps/paperless";
    settings = {
      PAPERLESS_ADMIN_USER = "monu";
      PAPERLESS_OCR_USER_ARGS = {
        invalidate_digital_signatures = true;
      };
    };
    user = "monu";
  };
}
