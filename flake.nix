{
  description = "NixOS configuration for my personal hosts";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    unstable.url = "nixpkgs/nixos-unstable";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    secrets = {
      url = "git+file:/home/monu/Desktop/nixos-config-secrets";
      flake = false;
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        darwin.follows = "";
        home-manager.follows = "";
      };
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      unstable,
      disko,
      secrets,
      agenix,
    }:
    let
      overlay =
        final: prev:
        let
          # Import nixpkgs for stable and unstable with unfree enabled
          stablePkgs = import nixpkgs {
            inherit (prev) system;
            config.allowUnfree = true;
          };
          unstablePkgs = import unstable {
            inherit (prev) system;
            config.allowUnfree = true;
          };
        in
        {
          nixpkgs = stablePkgs;
          unstable = unstablePkgs;
        };

      # Overlay to make `pkgs.unstable` available in configuration
      overlayModule =
        { config, pkgs, ... }:
        {
          nixpkgs.overlays = [ overlay ];
        };

      # To generate host configurations for all hosts.
      hostnames = builtins.attrNames (builtins.readDir ./hosts);
    in
    {
      nixosConfigurations = builtins.listToAttrs (
        builtins.map (hostname: {
          name = hostname;
          value = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = {
              channels = {
                inherit nixpkgs unstable agenix;
              };
              inherit secrets;
            };
            modules = [
              overlayModule
              disko.nixosModules.disko
              agenix.nixosModules.default
              ./hosts/${hostname}/configuration.nix
              (_: { networking.hostName = hostname; })
            ];
          };
        }) hostnames
      );
    };
}
