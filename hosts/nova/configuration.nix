{ config, pkgs, secrets, ... }:

{
  imports = [
    ./hardware-configuration.nix
    # ../../roles/apps/copyparty.nix
    ../../roles/common
    ../../roles/desktop
    "${secrets}/hosts/nova"
  ];
}
