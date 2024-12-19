{ lib, pkgs, ... }:

{
  age.secrets = {
    "service/signal-cli/contact-info" = {
      file = ../secrets/agenix/service/signal-cli/contact-info.age;
      mode = "644";
    };
  };

  environment.systemPackages = with pkgs.unstable; [ signal-cli ];
}
