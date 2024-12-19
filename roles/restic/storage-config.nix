{ config }:
{
  storagebox = "sftp:storagebox:/home/${config.networking.hostName}";
  storagebox-luna = "/mnt/storagebox-luna/${config.networking.hostName}";
  storagebox-nova = "/mnt/storagebox-nova/${config.networking.hostName}";
  storagebox-mega = "rclone:mega:storagebox";
}
