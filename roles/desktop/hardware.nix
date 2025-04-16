{ pkgs, ... }:

{
  imports = [
    ./disks.nix
    # ./printer.nix
  ];

  services.pipewire.enable = false;
  hardware = {
    # Enable Bluetooth
    bluetooth.enable = true;
    bluetooth.powerOnBoot = true;
    pulseaudio.enable = true;
  };
}
