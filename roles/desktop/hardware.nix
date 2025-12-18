{ pkgs, ... }:

{
  imports = [
    ./disks.nix
    # ./printer.nix
  ];

  services.pipewire.enable = false;
  services.pulseaudio.enable = true;
  hardware = {
    # Enable Bluetooth
    bluetooth.enable = true;
    bluetooth.powerOnBoot = true;
    # Install Udev rules for MX master
    logitech.wireless.enable = true;
  };
}
