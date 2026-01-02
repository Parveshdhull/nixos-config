{
  config,
  pkgs,
  secrets,
  ...
}:

{
  imports = [
    ./basic-tools.nix
    ./helpers.nix
    ./janitor.nix
    ./security.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.config.allowUnfree = true;

  services.locate.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.05";
}
