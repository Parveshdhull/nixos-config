{
  lib,
  pkgs,
  secrets,
  ...
}:

{

  users.users.monu.packages = [
    pkgs.yubikey-manager
  ];

  services.pcscd.enable = true;
  services.udev.packages = [ pkgs.yubikey-personalization ];

  # GPG and SSH
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Yubikey pam setup
  security.pam.yubico = {
    enable = true;
    mode = "challenge-response";
    id = [ (import "${secrets}/config").yubikey-serial ];
  };

  # Enable the u2f PAM module for login and sudo requests
  # https://nixos.wiki/wiki/Yubikey#Logging-in
  security.pam.services = {
    login.u2fAuth = true;
    sudo.u2fAuth = true;
  };
}
