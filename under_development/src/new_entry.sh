#!/bin/bash
#---------------------------------------------#
path=$HOME/.keys/etc/profile
profile=$HOME/.keys/etc/profile/profile
database=$HOME/.keys/etc/Database/database
master_file=$HOME/.keys/etc/profile/masterkey
install_file=$HOME/.keys/etc/path/install_path
ipath=`cat $install_file |awk '{print $1}'`
[ -d $path ] ||mkdir -p $path
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
