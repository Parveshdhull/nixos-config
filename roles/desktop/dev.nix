{ lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    android-tools
    gpick # color picker
    gnumake
    tmux
  ];
}
