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
  };
}
