{ config }:
{
  storagebox = "sftp:storagebox:/home/repositories/${config.networking.hostName}";
  storagebox-luna = "rclone:storagebox-luna:/repositories/${config.networking.hostName}";
  storagebox-nova = "rclone:storagebox-nova:/repositories/${config.networking.hostName}";
  storagebox-mega = "rclone:mega:storagebox";
}
