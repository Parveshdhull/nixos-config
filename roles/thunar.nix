{ lib, pkgs, ... }:

{
  users.users.monu.packages = [ pkgs.xarchiver ];

  # Thunar file manager setup
  programs.thunar.enable = true;
  programs.thunar.plugins = with pkgs.xfce; [
    thunar-archive-plugin
    thunar-volman
  ];

  # Thumbnails
  services.tumbler.enable = true;
  # Virutal filesystem - Trash and removable volumes
  services.gvfs.enable = true;
}
