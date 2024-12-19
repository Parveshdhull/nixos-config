{ lib, pkgs, ... }:

{
  age.secrets = {
    "service/github/credentials" = {
      file = ../secrets/agenix/service/github/credentials.age;
      mode = "644";
    };
  };

  environment.systemPackages = with pkgs; [
    gnupg # Required for signing commits
    pinentry-curses
  ];
}
