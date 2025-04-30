{
  lib,
  pkgs,
  secrets,
  ...
}:

{

  users.users.monu.packages = [
    pkgs.ccid
    pkgs.opensc
    pkgs.yubikey-manager
  ];

  services.udev.packages = [
    pkgs.yubikey-personalization
    pkgs.libu2f-host
  ];

  # When enabled gpg sometime don't detect device or detects after significant delay
  services.pcscd.enable = false; # Change to true when changing touch policy etc. for openpgp key

  # Necessary for GPG Agent.
  hardware.gpgSmartcards.enable = true; # Doesn't work pcscd is enabled

  # GPG and SSH
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
}
