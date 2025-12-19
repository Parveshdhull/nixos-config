{ lib, pkgs, ... }:

{
  imports = [
    ./dev.nix
    ./hardware.nix
    ./i3.nix
    ./firejail.nix
    # ./ledger.nix
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
    conky
    cryptsetup
    ffmpeg
    gnucash # Todo - migrate to firejail - Profile missing
    gparted
    ispell # Required for emacs flyspell
    keepassxc # Todo - migrate to firejail - Fix Yubikey Access
    libreoffice
    networkmanagerapplet
    pdftk # PDF Toolkit - Combine etc.
    pavucontrol # UI for sound control
    playerctl # Change songs on Spotify
    portfolio # Todo - migrate to firejail - Profile missing
    qrencode
    redshift
    rofi
    shfmt
    silver-searcher
    sxiv
    terminator
    upower # Check Bluetooth keyboard, mouse battery
    xclip # Required for prowser
    xdotool # Required for keybinding
    xorg.xkill
    xorg.xmodmap # Required for emoji keyboard
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
