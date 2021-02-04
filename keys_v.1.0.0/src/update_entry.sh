#!/bin/bash
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
#---------------------------------------------#
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
#                    Entry Details		             #
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
# <=================Main code==================>
#-------------------------------------------------#
# Decrypt the database before using
bash $ipath/src/encrypt.sh -dd $database
#last_updated=$(date +"%D ")
last_updated=$(date '+%d-%m-%Y')
echo
read -p "$bold$pur  Enter nickname:$rst" nickname
a=`grep " $nickname:" $database`
if [ $? -eq 0 ]
then
#echo "$bold$ylw Present Details:$rst"
# Encrypting the database
bash $ipath/src/encrypt.sh -ed $database
bash $ipath/src/show_details.sh $nickname

# Updating Database
echo "$bold$ylw Update New Deatils:$rst"
echo
#--->name
while true;do
read -p "$bold$pur     Username: $rst" username
 [ "$username" == "" ] && echo "$bold$red   Keys:$rst $bold Empty Name is not allowed$rst"||break
done
#--->Password
while true;do
read -p "$bold$pur     Password: $rst" password
 [ "$password" == "" ] && echo "$bold$red   Keys:$rst $bold Empty Name is not allowed$rst"||break
done
#--->Hints are not mandatory
read -p "$bold$pur     Hints   : $rst" hints

# Decrypt the database before using
bash $ipath/src/encrypt.sh -dd $database
# Removing old entry
sed -i "/$nickname:/d" $database

# Updating new entry
cat >> $database <<EOF
 $nickname:$username:$password:$hints:$last_updated

EOF
# Encrypting the database
bash $ipath/src/encrypt.sh -ed $database

echo;echo "$bold$red Keys:$rst $bold($grn $nickname$rst$bold) updated successfully.$rst";echo

else
echo ""
echo " $bold$red Keys:$rst$bold Nickname ($rst$bold${red}$nickname$rst$bold) doesn't exist in database.$rst"
# Encrypting the database
bash $ipath/src/encrypt.sh -ed $database
echo ""
fi

#-------------------------------------------------#
