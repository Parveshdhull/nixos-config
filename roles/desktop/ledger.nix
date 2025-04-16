{ pkgs, ... }:

{
  users.users.monu.packages = with pkgs.unstable; [
    ledger-live-desktop
  ];

  # Enable udev rules for Ledger
  hardware.ledger.enable = true;

  # Fix permissions
  # https://github.com/LedgerHQ/udev-rules/blob/master/20-hw1.rules
  services.udev.extraRules = ''
    KERNEL=="hidraw*", ATTRS{idVendor}=="2c97", MODE="0666"
  '';
}
