{
  config,
  secret-path,
  secrets,
  ...
}:
let
  hostName = config.networking.hostName;
in
{
  age.secrets = {
    "service/copyparty/monu" = {
      file = "${secrets}/agenix/service/copyparty/monu.age";
      mode = "644";
    };
    "service/copyparty/bob" = {
      file = "${secrets}/agenix/service/copyparty/bob.age";
      mode = "644";
    };
  };

  services.copyparty = {
    enable = true;
    user = "monu";
    settings = {
      i = "${hostName}.cosmos.vpn";
      p = [ (import "${secrets}/config/ports.nix").PORT_COPYPARTY ];
      no-reload = true;
      ignored-flag = false;
    };

    accounts = {
      monu.passwordFile = secret-path "service/copyparty/monu";
      bob.passwordFile = secret-path "service/copyparty/bob";
    };

    groups = {
      copyparty = [
        "monu"
        "bob"
      ];
    };

    volumes = {
      "/" = {
        path = if hostName == "luna" then "/mnt/data/apps/copyparty" else "/mnt/movies/";
        access = {
          r = "bob";
          rwma = "monu";
        };
        flags = {
          fk = 4;
          scan = 60;
          e2d = true;
          d2t = true;
          nohash = "\.iso$";
        };
      };
    };
  };
}
