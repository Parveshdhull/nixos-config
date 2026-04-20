{
  lib,
  pkgs,
  channels,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    bc
    curl
    dig
    file
    gnupg
    imagemagick
    ncdu
    net-tools
    numlockx
    python3
    traceroute
    trash-cli
    tree
    unzip
    vim
    wget
  ];
}
