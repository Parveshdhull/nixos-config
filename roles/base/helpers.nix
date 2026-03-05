{ config, pkgs, ... }:
{
  _module.args.secret-path = name: config.age.secrets."${name}".path;
}
