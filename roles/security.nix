{
  lib,
  pkgs,
  channels,
  ...
}:

{
  environment.systemPackages = with pkgs; [ channels.agenix.packages.${pkgs.system}.default ];

  networking.firewall.enable = true;
  networking.enableIPv6 = false;
  services.fail2ban.enable = true;
  security.pam.sshAgentAuth.enable = true;
}
