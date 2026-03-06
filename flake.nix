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
      getSystem = hostname: if hostname == "altair" then "aarch64-linux" else "x86_64-linux";

      # Overlay to make `pkgs.unstable` available in configuration
      overlayModule =
        { pkgs, ... }:
        {
          nixpkgs.overlays = [
            (final: prev: {
              unstable = import unstable {
                inherit (prev) system;
                config.allowUnfree = true;
              };
            })
            copyparty.overlays.default
          ];
        };

      hostnames = builtins.attrNames (builtins.readDir ./hosts);
    in
    {
      nixosConfigurations = builtins.listToAttrs (
        builtins.map (
          hostname:
          let
            system = getSystem hostname;
          in
          {
            name = hostname;
            value = nixpkgs.lib.nixosSystem {
              inherit system;
              specialArgs = {
                channels = { inherit nixpkgs unstable agenix; };
                inherit secrets;
              };
              modules = [
                overlayModule
                disko.nixosModules.disko
                agenix.nixosModules.default
                copyparty.nixosModules.default
                (_: {
                  environment.systemPackages = [
                    snitch.packages.${system}.default
                  ];
                })
                ./hosts/${hostname}/configuration.nix
                (_: { networking.hostName = hostname; })
              ];
            };
          }
        ) hostnames
      );
    };
}
