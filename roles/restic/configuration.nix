{
  pkgs,
  config,
  secret,
  secrets,
  ...
}:

{
  imports = [
    ./age-secrets.nix
  ];

  environment.etc = {
    "nebula/scripts/check-restic-backup".text =
      builtins.readFile ../../services/scripts/check-restic-backup;
  };

  users.users.monu.packages = [ pkgs.restic ];

  services.restic = {
    backups =
      (import ./host-backups.nix {
        inherit pkgs;
        inherit config;
        inherit secret;
        inherit secrets;
      }).currentHostBackups;
  };
}
