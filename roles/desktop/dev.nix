{ lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    android-tools
    # gpick # color picker
    gnumake
    scrcpy
    # nodejs
    # tmux
    # typescript
    # typescript-language-server
    # vscode
  ];
}
