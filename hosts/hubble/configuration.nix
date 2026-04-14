{
  config,
  pkgs,
  secrets,
  ...
}:

{
  imports = [
    ../../roles/base/basic-tools.nix
    ../../roles/base/helpers.nix
    ../../roles/base/janitor.nix
    ../../roles/base/security.nix
    ../../roles/desktop/firejail.nix
    ../../roles/desktop/i3.nix
    ../../roles/desktop/thunar.nix
    ../../roles/wireguard/wireguard-temp.nix
    "${secrets}/hosts/hubble"
  ];

  environment.systemPackages = with pkgs; [
    libxcvt
    rofi
    terminator
    xclip
    xdotool
  ];

  # base/default.nix
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.config.allowUnfree = true;

  services.locate.enable = true;
  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.05";
}
