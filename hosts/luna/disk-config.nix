{ lib, ... }:
{
  disko.devices = {
    disk = {
      main = {
        device = lib.mkDefault "/dev/sdb"; # WD SSD
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            boot = {
              name = "boot";
              size = "1M";
              type = "EF02";
            };
            esp = {
              name = "ESP";
              size = "500M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            root = {
              name = "root";
              size = "200G"; # Set to leave free space for optimal performance on the SSD - Over-provisioning
              content = {
                type = "luks";
                name = "crypted";
                content = {
                  type = "filesystem";
                  format = "ext4";
                  mountpoint = "/";
                  mountOptions = [ "defaults" ];
                };
              };
            };
          };
        };
      };
      disk_sda = {
        type = "disk";
        device = "/dev/sda"; # Samsung SSD
        content = {
          type = "gpt";
          partitions = {
            data = {
              name = "data";
              size = "200G";
              content = {
                type = "luks";
                name = "crypted_sda";
                content = {
                  type = "filesystem";
                  format = "ext4";
                  mountpoint = "/mnt/data";
                  mountOptions = [ "defaults" ];
                };
              };
            };
          };
        };
      };
    };
  };
}
