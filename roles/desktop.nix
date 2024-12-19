{ lib, pkgs, ... }:

{
  imports = [
    ./dev.nix
    ./hardware.nix
    ./i3.nix
    ./thunar.nix
    ../services/polkit.nix
  ];

  nixpkgs.config.allowUnfree = true;

  # System packages
  environment.systemPackages = with pkgs; [
    alsa-utils
    blueman
    chromium # Todo - Use ungoogled-chromium, brave or librewolf etc.
    cryptsetup
    czkawka
    discord
    feh
    flameshot
    firefox
    gparted
    zenity # Show popups and calendar
    gnucash
    keepassxc
    libreoffice
    networkmanagerapplet
    playerctl # Change songs on Spotify
    portfolio
    qrencode
    rclone
    redshift
    rofi
    signal-desktop
    silver-searcher
    simplescreenrecorder
    stretchly
    spotify
    sxiv
    sublime
    terminator
    upower # Check Bluetooth keyboard, mouse battery
    vlc
    xclip # Required for prowser
    xdotool # Required for keybinding
    xorg.xkill
    xorg.xmodmap # Required for emoji keyboard
  ];

  # Emacs setup
  services.emacs = {
    enable = true;
    package = pkgs.emacs;
  };

  services.upower.enable = true;

  programs.steam.enable = true;
}
