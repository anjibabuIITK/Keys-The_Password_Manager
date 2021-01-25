#!/bin/bash 
# This script is a part of password manager tool (Keys)
#---------------------------------------------------------------#
#Check .Password_Manager/etc/profile exists or not. if not create
#install_dir=`pwd`
install_dir=${KEYS_INSTALL_DIR}
key=${install_dir}/.keys
profile=${install_dir}/.keys/etc/profile/profile
recovery=${install_dir}/.keys/etc/profile/recovery
database=${install_dir}/.keys/etc/Database/database
install_path=${install_dir}/.keys/etc/path/install_path
master_file=${install_dir}/.keys/etc/profile/masterkey
ipath=`cat $install_path |awk '{print $1}'`
[ -d $key ] ||mkdir -p $key
#---------------------------------------------------------------#
#---------------------------------------------#
#path=$HOME/.keys/etc/profile
#profile=$HOME/.keys/etc/profile/profile
#database=$HOME/.keys/etc/Database/database
#master_file=$HOME/.keys/etc/profile/masterkey
#install_file=$HOME/.keys/etc/path/install_path
#ipath=`cat $install_file |awk '{print $1}'`
#[ -d $path ] ||mkdir -p $path
#---------------------------------------------#
# function to check nickname
function Is_exist() {
# Decrypt the database before using
bash $ipath/src/encrypt.sh -dd $database
a=`grep " $1:" $database`
if [ "$?" == "0" ];then
# Encrypt the database after using
bash $ipath/src/encrypt.sh -ed $database
remove $1
else
echo " Keys: nickname ($1) Doesn't exist in Database."
# Encrypt the database after using
bash $ipath/src/encrypt.sh -ed $database
fi
}
#-------------------------------------------------#
function remove() {
read -p "Are you sure want to remove $1? [yes/no]: " option
if [ "$option" == "yes" ];then
# Decrypt the database before using
bash $ipath/src/encrypt.sh -dd $database
sed -i "/$1:/d" $database
# encrypt the database After using
bash $ipath/src/encrypt.sh -ed $database
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
Is_exist $nickname
#---------------------------------------------#
