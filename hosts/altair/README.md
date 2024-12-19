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

9. Unmount the NixOS minimal environment and reboot the system.

10. Modify `/etc/ssh/ssh_config` to change the user from `nixos` to `monu`.

11. Connect to Altair via SSH:
    ```bash
    ssh altair
    ```

12. Run `scp /mnt/secrets/keys/altair monu@altair.cosmos.vpn: /mnt/secrets/keys/altair`

13. Rebuild using `nixos-rebuild switch --flake .#altair --target-host monu@altair.cosmos.vpn`

# Checklist (Post - Installation)
- [ ] Register signal-cli using `signal-cli link`
