{ lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    android-tools
    # gpick # color picker
    gnumake
    # nodejs
    # tmux
    # typescript
    # typescript-language-server
    # vscode
  ];
}
