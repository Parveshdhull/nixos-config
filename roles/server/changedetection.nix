{
  lib,
  pkgs,
  secrets,
  ...
}:
{
  services.changedetection-io = {
    enable = true;
    listenAddress = (import "${secrets}/config/hosts.nix").altair;
    port = (import "${secrets}/config/ports.nix").PORT_CHANGE_DETECTION;
    webDriverSupport = true;
  };
}
