{ lib, pkgs, ... }:

{
  imports = [
    # ./hubble-bridge.nix # Only needed once, don't need anymore
  ];

  environment.systemPackages = with pkgs; [
    android-tools
    # gpick # color picker
    gnumake
    # nodejs
    # tmux
    # typescript
    # typescript-language-server
    # vscode

    ## C
    # gcc
    # gdb
  ];
}
