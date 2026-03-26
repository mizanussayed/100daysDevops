# Day 10: Linux Bash Scripts

The production support team of xFusionCorp Industries is working on developing some bash scripts to automate different day to day tasks. One is to create a bash script for taking websites backup. They have a static website running on App Server 1 in Stratos Datacenter, and they need to create a bash script named media_backup.sh which should accomplish the following tasks. (Also remember to place the script under /scripts directory on App Server 1).

a. Create a zip archive named xfusioncorp_media.zip of /var/www/html/media directory.

b. Save the archive in /backup/ on App Server 1. This is a temporary storage, as backups from this location will be clean on weekly basis. Therefore, we also need to save this backup archive on Nautilus Backup Server.

c. Copy the created archive to Nautilus Backup Server server in /backup/ location.

d. Please make sure script won't ask for password while copying the archive file. Additionally, the respective server user (for example, tony in case of App Server 1) must be able to run it.

e. Do not use sudo inside the script.

Note:
The zip package must be installed on given App Server before executing the script. This package is essential for creating the zip archive of the website files. Install it manually outside the script.

## Solution
Here is a sample bash script named `media_backup.sh` that accomplishes the tasks mentioned:

```bash
#!/bin/bash
# Define variables
SOURCE_DIR="/var/www/html/media"
BACKUP_DIR="/backup"
ARCHIVE_NAME="xfusioncorp_media.zip"
SERVER="172.16.238.16" # stbkp01
USER="clint"
zip -r "$BACKUP_DIR/$ARCHIVE_NAME" "$SOURCE_DIR"
scp "$BACKUP_DIR/$ARCHIVE_NAME" "$USER@$SERVER:$BACKUP_DIR/"
```

## short script
```bash
#!/bin/bash
zip -r "/backup/xfusioncorp_media.zip" "/var/www/html/media"
scp "/backup/xfusioncorp_media.zip" "clint@stbkp01:/backup/"
```
### Instructions to Set Up Passwordless SSH
To ensure that the script can copy the archive to the Nautilus Backup Server without asking for a password, you need to set up SSH key-based authentication between App Server 1 and the Nautilus Backup Server.

1. Generate an SSH key pair on App Server 1 (if you haven't already):
```bash
ssh-keygen -t rsa -b 2048
```
 Follow the prompts to save the key (you can press Enter to accept the default location and leave the passphrase empty).

2. Copy the public key to the Nautilus Backup Server:
```bash
ssh-copy-id tony@172.16.238.16
```
 This command will prompt you for the password of the `tony` user on the Nautilus Backup Server. After entering the password, the public key will be added to the `~/.ssh/authorized_keys` file on the Nautilus Backup Server.

### Final Notes
install zip package on App Server 1 before running the script:
```bash 
sudo apt-get install zip
```