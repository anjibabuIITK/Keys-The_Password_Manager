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
# Defining text colors
red=`tput setaf 1`
grn=`tput setaf 2`
ylw=`tput setaf 3`
blu=`tput setaf 4`
pur=`tput setaf 5`
rst=`tput sgr0`
bold=`tput bold`
#---------------------------------------------------------------#
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
echo;echo "$bold$red  Keys:$rst$bold nickname ($1) Doesn't exist in Database.$rst"
# Encrypt the database after using
bash $ipath/src/encrypt.sh -ed $database
fi
}
#-------------------------------------------------#
function remove() {
echo;read -p "$bold$red  Are you sure want to remove$rst$bold $1$rst$bold$red? [$rst${bold}yes/no$rst$bold$red]:$rst " option
if [ "$option" != "" ];then
   if [ "$option" == "yes" ];then
# Decrypt the database before using
bash $ipath/src/encrypt.sh -dd $database
sed -i "/$1:/d" $database
# encrypt the database After using
bash $ipath/src/encrypt.sh -ed $database
    echo;echo "$bold$red  Keys:$rst$bold Entry for nickname ($1) has been removed.$rst"
  else
    echo;echo "$bold$red  Keys:$rst$bold nickname ($1) has not been removed.$rst"
  fi
else
echo;echo "$bold$red  Keys:$rst$bold nickname ($1) has not been removed.$rst"
fi
}
#-------------------------------------------------#
function print_close() {
cat << EOF

$bold <------------------------------------------------------------>$rst
EOF
}
#---------------------------------------------#
#  <==========MAIN CODE START=============>
#---------------------------------------------#
if [ $# -eq 0 ] ;then
bash $ipath/src/list.sh
print_close;echo
#  while true;do
    read -p "$bold$pur Enter nickname: $rst" nickname
      if [ "$nickname" != "" ];then
         Is_exist $nickname
#         break
      else
         echo;echo "$bold$red  Keys:$rst$bold Empty nickname ($1) is NOT allowed.$rst"
         exit
      fi
#  done
else
Is_exist $1
fi
#---------------------------------------------#
