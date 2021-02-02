#!/bin/bash
# Download rclone
q=`which rclone`
if [ "$?" != "0" ];then
curl -O https://downloads.rclone.org/rclone-current-linux-amd64.zip
unzip rclone-current-linux-amd64.zip
cd rclone-*-linu-amd64
#install rclone
sudo cp rclone /usr/bin/
sudo chown root:root /usr/bin/rclone
sudo chmod 755 /usr/bin/rclone
#Install manpage
#sudo mkdir -p /usr/local/share/man/man1
#sudo cp rclone.1 /usr/local/share/man/man1/
#sudo mandb 
#
#Ref:https://rclone.org/install/
else
echo "Keys: rclone---> Found."
fi
