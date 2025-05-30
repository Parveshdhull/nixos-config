{ lib, pkgs, ... }:

{
  users.users.monu.packages = [
    pkgs.telegram-desktop
  ];
}
