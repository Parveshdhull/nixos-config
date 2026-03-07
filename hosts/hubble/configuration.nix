{
  config,
  pkgs,
  secrets,
  ...
}:

{
  imports = [
    ../../roles/base
    ../../roles/desktop/firejail.nix
    ../../roles/desktop/i3.nix
    ../../roles/desktop/thunar.nix
    ../../roles/wireguard/wireguard-temp.nix
    "${secrets}/hubble"
  ];
}
