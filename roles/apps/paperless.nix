{
  lib,
  pkgs,
  secret-path,
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
    passwordFile = secret-path "service/paperless/pass";
    port = (import "${secrets}/config/ports.nix").PORT_PAPERLESS;
    dataDir = "/mnt/data/apps/paperless";
    settings = {
      PAPERLESS_ADMIN_USER = "monu";
      PAPERLESS_ENABLE_NLTK = false;
      PAPERLESS_OCR_USER_ARGS = {
        invalidate_digital_signatures = true;
        continue_on_soft_render_error = true;
      };
    };
  };
}
