{
  description = "NixOS configuration for my personal hosts";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    unstable.url = "nixpkgs/nixos-unstable";
    secrets = {
      url = "git+ssh://git@github.com/parveshdhull/nixos-config-secrets";
      # url = "path:/mnt/data/nebula/nixos-config-secrets";
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
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    copyparty.url = "github:9001/copyparty";
    copyparty.inputs.nixpkgs.follows = "nixpkgs";
    snitch.url = "github:karol-broda/snitch";
    snitch.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      unstable,
      disko,
      secrets,
      agenix,
      copyparty,
      snitch,
    }:
    let
      # Overlay to make `pkgs.unstable` available in configuration
      overlayModule =
        { pkgs, ... }:
        {
          nixpkgs.overlays = [
            (final: prev: {
              nixpkgs = import nixpkgs {
                inherit (prev) system;
                config.allowUnfree = true;
              };
              unstable = import unstable {
                inherit (prev) system;
                config.allowUnfree = true;
              };
            })
            copyparty.overlays.default
          ];
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
              copyparty.nixosModules.default
              (_: {
                environment.systemPackages = [
                  snitch.packages.x86_64-linux.default
                ];
              })
              ./hosts/${hostname}/configuration.nix
              (_: { networking.hostName = hostname; })
            ];
          };
        }) hostnames
      );
    };
}
