{ pkgs, ... }:

{
  environment.etc = {
    "nebula/scripts/initial-setup".text = builtins.readFile ./scripts/initial-setup;
    "nebula/scripts/directory-setup".text = builtins.readFile ./scripts/directory-setup;
    "nebula/scripts/dotfiles-setup".text = builtins.readFile ./scripts/dotfiles-setup;
  };

  environment.systemPackages = with pkgs; [
    git
    stow
  ];
  systemd.services.initial-setup = {
    description = "Initial setup: create directories and configure dotfiles, etc.";
    after = [ "network.target" ];
    path = [
      pkgs.bash
      pkgs.git
      pkgs.hostname
      pkgs.openssh
      pkgs.stow
    ];
    serviceConfig = {
      ExecStart = "/run/current-system/sw/bin/bash /etc/nebula/scripts/initial-setup";
      User = "monu";
    };
    wantedBy = [ "multi-user.target" ];
  };
}
