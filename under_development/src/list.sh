#!/bin/bash
#---------------------------------------------------------------#
#Check .Password_Manager/etc/profile exists or not. if not create
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
#
#path=$HOME/.keys/etc/profile
#profile=$HOME/.keys/etc/profile/profile
#database=$HOME/.keys/etc/Database/database
#master_file=$HOME/.keys/etc/profile/masterkey
#install_file=$HOME/.keys/etc/path/install_path
#ipath=`cat $install_file |awk '{print $1}'`
#[ -d $path ] ||mkdir -p $path
#---------------------------------------------#
function print_welcome() {
cat << EOF
#------------------------------------------------------------#
#               Welcome to Password Manager		     #    
#                 Available nick names		             #
#------------------------------------------------------------#

EOF
}
#-------------------------------------------------#
function print_close() {
cat << EOF
#------------------------------------------------------------#

EOF
}
#-------------------------------------------------#
# Main code
#-------------------------------------------------#
# Decrypt the database before using
bash $ipath/src/encrypt.sh -dd $database
array=`awk {'print $1'} $database|cut -d ':' -f1`
j=0;k=0
for i in $array;do
echo "$i" >> tmp$k
j=`expr $j + 1`
if [ $j -eq 5 ] 
then
 k=`expr $k + 1`
j=0
fi
done
# Encrypt the database after using
bash $ipath/src/encrypt.sh -ed $database
#
paste tmp* > FILE
rm tmp*
# Welcome Msg
#print_welcome
echo "$bold$ylw                   Available Nicknames$rst"
echo "$bold <------------------------------------------------------------>$rst"
#cat FILE
while read row;do
echo "$bold $row $rst"
done <FILE
#print_close
rm FILE

