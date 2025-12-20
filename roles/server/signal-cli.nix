{
  lib,
  pkgs,
  secrets,
  ...
}:

{
  age.secrets = {
    "service/signal-cli/contact-info" = {
      file = "${secrets}/agenix/service/signal-cli/contact-info.age";
      owner = "monu";
    };
  };

  environment.systemPackages = with pkgs; [ signal-cli ];
}
