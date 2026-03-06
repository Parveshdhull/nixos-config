# Setup Instructions

1. Add a server entry for Altair in `/etc/ssh/ssh_config`.

2. Boot the server using NixOS minimal.

3. Use `passwd` to set a password for the `nixos` user.

4. Log in to the NixOS server and run the following commands to create an SSH key directory and add your public key:
    ```bash
    mkdir ~/.ssh
    echo public-key > ~/.ssh/authorized_keys
    ```

5. Verify that SSH is working with private key authentication.

6. Run the following command to generate hardware configuration files:
    ```bash
    sudo nixos-generate-config --no-filesystems --dir /mnt
    ```

7. Test the VM by running:
    ```bash
    nix run github:nix-community/nixos-anywhere -- --flake .#altair --vm-test nixos@altair
    ```

8. For deployment, run the following command using the latest release revision:
    ```bash
    nix run github:nix-community/nixos-anywhere/<last-release-revision> -- --flake .#altair nixos@altair
    ```
    Note: hetzner cloud sometime have issues with special characters like (!), so don't use them in disk encryption password
    Extra Flags:
    --generate-hardware-config nixos-generate-config ./hosts/altair/hardware-configuration.nix (For generating hardware config)
    --build-on remote (For different architectue like aarch64-linux)

9. Reboot in NixOS minimal and run
   ```bash
   sudo -s
   passwd
   cryptsetup luksOpen /dev/sda3 temp_mount
   mkdir -p /mnt
   mount /dev/mapper/temp_mount /mnt
   mkdir -p /mnt/mnt/secrets/keys
   scp /mnt/secrets/keys/altair root@server-ip: /mnt/mnt/secrets/keys/altair
   ```
   or
   Use hashedPassword instead of file for initial authentication and for uploading age identity key form console

10. Unmount the NixOS minimal environment and reboot the system.

11. Connect to Altair via SSH:
    ```bash
    ssh altair
    ```

# Checklist
- [ ] Make sure network interface name in wireguard-server.nix file matches with actual interface name for server.
