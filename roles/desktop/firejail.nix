{ lib, pkgs, ... }:
{
  programs.firejail = {
    enable = true;
    wrappedBinaries =
      lib.mapAttrs'
        (name: pkg: {
          inherit name;
          value = {
            executable = "${lib.getBin pkg}/bin/${name}";
            profile = "${pkgs.firejail}/etc/firejail/${name}.profile";
          };
        })
        (
          with pkgs;
          {
            inherit
              brave
              discord
              feh
              flameshot
              librewolf
              signal-desktop
              simplescreenrecorder
              spotify
              steam
              vlc
              zathura
              ;
          }
        )
      // {
        telegram-desktop = {
          executable = "${lib.getBin pkgs.telegram-desktop}/bin/Telegram";
          profile = "${pkgs.firejail}/etc/firejail/telegram.profile";
        };
      };
  };

}
