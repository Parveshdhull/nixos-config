{
  lib,
  config,
  pkgs,
  secret-path,
  secrets,
  ...
}:
let
  host = (import "${secrets}/config/hosts.nix").luna;
  port = (import "${secrets}/config/ports.nix").PORT_MEMOS;
in
{
  services.memos = {
    enable = true;
    dataDir = "/mnt/data/apps/memos";
    package = pkgs.unstable.memos;
    settings = {
      MEMOS_MODE = "prod";
      MEMOS_ADDR = host;
      MEMOS_PORT = port;
      MEMOS_DATA = config.services.memos.dataDir;
      MEMOS_DRIVER = "sqlite";
      MEMOS_INSTANCE_URL = "http://${host}:${toString port}";
    };
  };
}
