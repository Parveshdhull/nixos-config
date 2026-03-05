{
  config,
  pkgs,
  callPackage,
  ...
}:

{

  programs.dconf.enable = true; # Requires for persisting configurations for programs like Gnucash
  environment.pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw

  environment.systemPackages = with pkgs; [
    dunst # Notification daemon
    libnotify # For notifications
    picom
  ];

  services = {
    displayManager.defaultSession = "none+i3";

    xserver = {
      enable = true;
      displayManager.lightdm.greeters.enso.enable = true;

      windowManager.i3 = {
        enable = true;
        extraPackages = with pkgs; [
          dmenu
          i3status
          i3blocks
        ];
      };
    };
  };
}
