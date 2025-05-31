{ lib, pkgs, ... }:

{
  imports = [
    ./dev.nix
    ./hardware.nix
    ./i3.nix
    ./ledger.nix
    ./temp.nix
    ./thunar.nix
    ./yubikey.nix
    ../../services/polkit.nix
    ../../services/restic-report.nix
  ];

  nixpkgs.config.allowUnfree = true;

  # System packages
  environment.systemPackages = with pkgs; [
    alsa-utils
    appimage-run
    blueman
    brave
    chromium # Todo - Remove after brave migration
    conky
    cryptsetup
    discord
    feh
    ffmpeg
    flameshot
    gparted
    gnucash
    ispell # Required for emacs flyspell
    keepassxc
    libreoffice
    librewolf
    networkmanagerapplet
    pdftk # PDF Toolkit - Combine etc.
    playerctl # Change songs on Spotify
    portfolio
    qrencode
    redshift
    rofi
    signal-desktop
    silver-searcher
    simplescreenrecorder
    spotify
    sxiv
    terminator
    upower # Check Bluetooth keyboard, mouse battery
    vlc
    xclip # Required for prowser
    xdotool # Required for keybinding
    xorg.xkill
    xorg.xmodmap # Required for emoji keyboard
    zenity # Show popups and calendar
  ];

  # Emacs setup
  services.emacs = {
    enable = true;
    package = pkgs.emacs;
  };

  services.upower.enable = true;

  programs = {
    steam.enable = true;
    slock.enable = true;
  };
}
