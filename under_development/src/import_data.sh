#!/bin/bash
#---------------------------------------------------------------#
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
#----------------------------------------------#
function IMPORT() {
nickname=$1
# Decrypt the database before using
bash $ipath/src/encrypt.sh -dd $database
cat >> $database <<EOF
 $nickname:$username:$password:$hints:$last_updated

EOF
# Encrypt the database after using
bash $ipath/src/encrypt.sh -ed $database
}
#-------------------------------------------------#
# function to check nickname
function Is_exist() {
# Decrypt the database before using
bash $ipath/src/encrypt.sh -dd $database
a=`grep " $1:" $database`
if [ "$?" == "0" ];then
echo "$bold$red Keys:$rst $bold Nickname ($red $1 $rst) $bold already exist.$rst"
echo "$bold$red Keys:$rst $bold Skipping entry for nickname ($1)$rst"
# Encrypt the database after using
bash $ipath/src/encrypt.sh -ed $database
else
i=`expr $i + 1`
# Encrypt the database after using
bash $ipath/src/encrypt.sh -ed $database
IMPORT $1
fi
}
#----------------------------------------------#
# <=========== MAIN CODE ==============>
#----------------------------------------------#
i=0
last_updated=$(date +"%D ")
if [ "$1" != "" ];then
#--->
DATA=$1
echo;echo "$bold$ble  Importing from: $DATA$rst"
while read line;do
echo "$line">>new_file
nickname=`echo $line|cut -d ":" -f1`
username=`echo $line|cut -d ":" -f2`
password=`echo $line|cut -d ":" -f3`
hints=`echo $line|cut -d ":" -f4`
#echo "$nickname"
Is_exist $nickname
done <$DATA
#<---
else
echo "$bold$red Keys:$rst$bold File Not found.$rst"
fi
#--->
echo "$bold$red Keys:$rst$bold $i Entries have been imported.$rst"
#----------------------------------------------#
