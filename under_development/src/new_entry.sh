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
# function to check nickname
function Is_exist() {
# Decrypt the database before using
bash $ipath/src/encrypt.sh -de $database
a=`grep " $1:" $database`
if [ "$?" == "0" ];then
echo " Keys: nickname already exist. Try other name."
# Encrypt the database after using
bash $ipath/src/encrypt.sh -en $database
else
echo " Keys: $1 ---> OK"
# Encrypt the database after using
bash $ipath/src/encrypt.sh -en $database
break
fi
}
#-------------------------------------------------#
#    <=========== Main code ============>
#-------------------------------------------------#
while true;do
echo
last_updated=$(date +"%D ")
#print_welcome
while true;do
read -p "Give  nickname:" nickname
Is_exist $nickname
done

read -p "User ID/username: " username
read -p "Password: " password
read -p "Any hints :" hints
#echo "updated on = $last_updated"

# Decrypt the database before using
bash $ipath/src/encrypt.sh -de $database
cat >> $database <<EOF
 $nickname:$username:$password:$hints:$last_updated

EOF
# Encrypt the database after using
bash $ipath/src/encrypt.sh -en $database
echo " Entry has been registred successfully."
echo

read -p " Want to add another entry? [yes/no] : " option
[[ "$option" == "yes" ]] ||break

done
#print_close
#-------------------------------------------------#
# <==========Anji Babu Kapakayala===========>
#-------------------------------------------------#
