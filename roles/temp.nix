{ lib, pkgs, ... }:

{
  networking.firewall.trustedInterfaces = [ "enp7s0" "wlp5s0" ];

  users.users.monu.packages = [
    pkgs.czkawka-full
    pkgs.ffmpeg
  ];
}
