{ lib, pkgs, ... }:

{
  networking.firewall.trustedInterfaces = [
    "enp7s0"
    "wlp5s0"
  ];

  services.pcscd.enable = true;

  users.users.monu.packages = [
    pkgs.czkawka-full
    pkgs.ffmpeg
  ];
}
