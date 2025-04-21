{ lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    android-studio
    android-tools
    gpick # color picker
    gnumake
    tmux
  ];
}
