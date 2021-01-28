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
# <=========== MAIN CODE ==============>
#---------------------------------------------------------------#
i=0
last_updated=$(date +"%D ")
if [ "$1" != "" ];then
#--->
DATA=$1
echo;echo "$bold$ylw  Exporting Database To: $DATA$rst"
# Decrypt the database before using
bash $ipath/src/encrypt.sh -dd $database
while read line;do
nickname=`echo $line|cut -d ":" -f1`
username=`echo $line|cut -d ":" -f2`
password=`echo $line|cut -d ":" -f3`
hints=`echo $line|cut -d ":" -f4`
if [ "$nickname" != "" ];then
 if [ "$nickname" != "exit" ];then
cat >>$DATA<<EOF
[$nickname]:
 Nickname : $nickname
 Username : $username
 Password : $password
 Hints	  : $hints

EOF
i=`expr $i + 1`
fi
fi
done <$database
# Encrypt the database after using
bash $ipath/src/encrypt.sh -ed $database
#<---
else
echo "$bold$red Keys:$rst$bold File name has Not Given.$rst"
fi
#--->
#echo "$bold$red Keys:$rst$bold Database has been exported to $DATA.$rst"
echo "$bold$red Keys:$rst$bold $i Entries are exported to $DATA.$rst"
#---------------------------------------------------------------#
