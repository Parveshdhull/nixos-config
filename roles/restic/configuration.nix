{
  pkgs,
  config,
  secret,
  ...
}:

{
  imports = [
    ./age-secrets.nix
    ../../services/check-restic-backups.nix
  ];

  users.users.monu.packages = [ pkgs.restic ];

  services.restic = {
    backups =
      (import ./host-backups.nix {
        inherit pkgs;
        inherit config;
        inherit secret;
      }).currentHostBackups;
  };
}
