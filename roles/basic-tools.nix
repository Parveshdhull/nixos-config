{
  lib,
  pkgs,
  channels,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    bc
    file
    gnupg
    imagemagick
    ncdu
    numlockx
    python3
    trash-cli
    tree
    unzip
    vim
  ];
}
