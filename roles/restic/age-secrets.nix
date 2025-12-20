{ config, secrets, ... }:

{
  age.secrets =
    let
      commonSecrets = {
        "service/restic/pass" = {
          file = "${secrets}/agenix/service/restic/pass.age";
          owner = "monu";
        };
        "service/rclone/conf" = {
          file = "${secrets}/agenix/service/rclone/conf.age";
          owner = "monu";
        };
      };
    in
    if config.networking.hostName == "nova" then
      commonSecrets
      // {
        "service/restic/pass-mega" = {
          file = "${secrets}/agenix/service/restic/pass-mega.age";
          owner = "monu";
        };
      }
    else
      commonSecrets;
}
