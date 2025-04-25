{ config, secrets, ... }:

{
  age.secrets =
    let
      commonSecrets = {
        "service/restic/pass" = {
          file = "${secrets}/agenix/service/restic/pass.age";
          mode = "644";
        };
        "service/rclone/conf" = {
          file = "${secrets}/agenix/service/rclone/conf.age";
          mode = "644";
        };
      };
    in
    if config.networking.hostName == "nova" then
      commonSecrets
      // {
        "service/restic/pass-mega" = {
          file = "${secrets}/agenix/service/restic/pass-mega.age";
          mode = "644";
        };
      }
    else
      commonSecrets;
}
