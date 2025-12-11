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
    ../../services/gitman.nix
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
    pavucontrol # UI for sound control
    playerctl # Change songs on Spotify
    portfolio
    qrencode
    redshift
    rofi
    shfmt
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
    zathura # PDF viewer with auto reload feature
    zenity # Show popups and calendar
  ];

  services = {
    emacs.enable = true;
    upower.enable = true;
    physlock = {
      enable = true;
      allowAnyUser = true;
    };
  };

  programs.steam.enable = true;
}
