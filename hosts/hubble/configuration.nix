{
  config,
  pkgs,
  secrets,
  ...
}:

{
  imports = [
    ../../roles/base/basic-tools.nix
    ../../roles/base/helpers.nix
    ../../roles/base/janitor.nix
    ../../roles/base/security.nix
    ../../roles/desktop/firejail.nix
    ../../roles/desktop/i3.nix
    ../../roles/desktop/thunar.nix
    "${secrets}/hubble"
  ];
}
