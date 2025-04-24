{ config }:
{
  # Common repositories
  storagebox = "sftp:storagebox:/home/repositories/${config.networking.hostName}";
  # Luna repositories
  storagebox-luna = "/mnt/storagebox-luna/repositories/luna";
  # Nova repositories
  storagebox-nova = "/mnt/storagebox-nova/repositories/nova";
  storagebox-mega = "rclone:mega:storagebox";
}
