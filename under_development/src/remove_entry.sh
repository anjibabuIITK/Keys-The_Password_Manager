#!/bin/bash 
# This script is a part of password manager tool (Keys)
#---------------------------------------------#
path=$HOME/.keys/etc/profile
profile=$HOME/.keys/etc/profile/profile
database=$HOME/.keys/etc/Database/database
master_file=$HOME/.keys/etc/profile/masterkey
install_file=$HOME/.keys/etc/path/install_path
ipath=`cat $install_file |awk '{print $1}'`
[ -d $path ] ||mkdir -p $path
#---------------------------------------------#
function remove() {
read -p "Are you sure want to remove $1? [yes/no]: " option
if [ "$option" == "yes" ];then
# Decrypt the database before using
bash $ipath/src/encrypt.sh -de $database
sed -i "/$1:/d" $database
# encrypt the database After using
bash $ipath/src/encrypt.sh -en $database
echo "nickname ($1) has been removed."
else
echo "nickname ($1) has not removed."

fi
}
#---------------------------------------------#
#  <==========MAIN CODE START=============>
#---------------------------------------------#
bash $ipath/src/list.sh
read -p "Enter nickname: " nickname
remove $nickname
#---------------------------------------------#
