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
#path=$HOME/.keys/etc/profile
#profile=$HOME/.keys/etc/profile/profile
#database=$HOME/.keys/etc/Database/database
#master_file=$HOME/.keys/etc/profile/masterkey
#install_file=$HOME/.keys/etc/path/install_path
#ipath=`cat $install_file |awk '{print $1}'`
#[ -d $path ] ||mkdir -p $path
#---------------------------------------------#
function header() {
cat << EOF

$bold $blu  <=============== $rst $bold $red Welcome to Keys$rst $bold $blu ===============>$rst
$bold <------------------------------------------------------------>$rst
 		    $bold $ylw $@ $rst

EOF
}
#-------------------------------------------------#
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
# function to check nickname
function Is_exist() {
# Decrypt the database before using
bash $ipath/src/encrypt.sh -dd $database
a=`grep " $1:" $database`
if [ "$?" == "0" ];then
echo "$bold$red Keys:$rst $bold Nickname ($red $1 $rst) $bold already exist. Try other name.$rst"
# Encrypt the database after using
bash $ipath/src/encrypt.sh -ed $database
else
#echo "$bold$red Keys:$rst $bold $1 --->$rst$bold$grn Available$rst"
# Encrypt the database after using
bash $ipath/src/encrypt.sh -ed $database
break
fi
}
#-------------------------------------------------#
#    <=========== Main code ============>
#-------------------------------------------------#
echo;echo "$bold$ylw New Entry : $rst"
while true;do
echo
last_updated=$(date +"%D ")
#print_welcome
while true;do
read -p "$bold$pur   Nickname: $rst" nickname
Is_exist $nickname
done

read -p "$bold$pur   Username: $rst" username
read -p "$bold$pur   Password: $rst" password
read -p "$bold$pur   Hints   : $rst" hints
#echo "updated on = $last_updated"

# Decrypt the database before using
bash $ipath/src/encrypt.sh -dd $database
cat >> $database <<EOF
 $nickname:$username:$password:$hints:$last_updated

EOF
# Encrypt the database after using
bash $ipath/src/encrypt.sh -ed $database
echo "$bold$red Keys:$rst $bold Entry has been registred successfully.$rst"
echo

read -p "$bold$blu Want to add another entry? [$rst $bold yes/no$rst $bold$blu] :$rst " option
[[ "$option" == "yes" ]] ||break
clear
header
done
#print_close
#-------------------------------------------------#
# <==========Anji Babu Kapakayala===========>
#-------------------------------------------------#
