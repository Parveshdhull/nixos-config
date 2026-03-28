{
  lib,
  pkgs,
  secrets,
  secret-path,
  ...
}:

{
  age.secrets."service/u2f/authfile" = {
    file = "${secrets}/agenix/service/u2f/authfile.age";
    owner = "root";
    mode = "644";
  };

  users.users.monu.packages = [
    pkgs.opensc
    pkgs.yubikey-manager
  ];

  services.udev.packages = [
    pkgs.yubikey-personalization
    pkgs.libu2f-host
  ];

  hardware.gpgSmartcards.enable = true;
  services.pcscd.enable = true;

  # GPG and SSH
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Touch detector
  programs.yubikey-touch-detector.enable = true;

  # Enable U2F
  security.pam.u2f = {
    enable = true;
    control = "sufficient";
    settings.authfile = secret-path "service/u2f/authfile";
  };

  # Enable the u2f PAM module for su
  security.pam.services.su.u2fAuth = true;
}
