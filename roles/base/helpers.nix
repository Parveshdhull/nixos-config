{ config, pkgs, ... }:
{
  _module.args.secret = name: config.age.secrets."${name}".path;
}
