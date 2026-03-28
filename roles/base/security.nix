{
  lib,
  pkgs,
  config,
  channels,
  ...
}:

{
  environment.systemPackages = with pkgs; [ channels.agenix.packages.${pkgs.system}.default ];

  networking.firewall.enable = true;
  networking.enableIPv6 = false;
  services.fail2ban.enable = true;

  security.sudo.wheelNeedsPassword = if config.networking.hostName == "nova" then true else false;

  # https://xeiaso.net/blog/paranoid-nixos-2021-07-18/
  nix.settings.allowed-users = [ "@wheel" ];
  environment.defaultPackages = lib.mkForce [ ];
}
