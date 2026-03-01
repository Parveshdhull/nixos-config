# Setup Instructions

1. Boot into nixos minimial
2. Create and format paritions
   ```
   mkfs.ext4 -L nixos /dev/sda1
   mkfs.fat -F 32 -n boot /dev/sda3
   ```
3. Mount paritions
   ```
   mount /dev/disk/by-label/nixos /mnt
   mount /dev/disk/by-label/boot /mnt/boot
   ```
4. `nixos-generate-config --root /mnt`
5. `nixos-install`
6. Boot into installed nixos
7. `mount /dev/disk/by-label/data /mnt/data/`
8. `cp /etc/nixos/hardware-configuration.nix /mnt/data/nebula/nixos-config/hosts/nova/hardware-configuration.nix`
9. bn
