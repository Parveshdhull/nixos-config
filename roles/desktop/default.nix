{ lib, pkgs, ... }:

{
  imports = [
    ./dev.nix
    ./firejail.nix
    ./hardware.nix
    ./i3.nix
    # ./ledger.nix
    ./temp.nix
    ./thunar.nix
    ./vm.nix
    # ./wireguard-temp.nix
    ./yubikey.nix
    ../../services/gitman.nix
    ../../services/polkit.nix
    ../../services/restic-report.nix
  ];

  # System packages
  environment.systemPackages = with pkgs; [
    alsa-utils
    appimage-run
    blueman
    conky
    cryptsetup # For disk encryption
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
