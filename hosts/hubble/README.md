1. nix flake update

2. nix build .#nixosConfigurations.hubble.config.system.build.vm

3. ./result/bin/run-nixos-vm
