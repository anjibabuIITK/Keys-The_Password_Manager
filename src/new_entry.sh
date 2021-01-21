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
#    <=========== Main code ============>
#-------------------------------------------------#
# Decrypt the database before using
bash $ipath/src/encrypt.sh -de $database
last_updated=`date`
#print_welcome
read -p "Give  nickname:" nickname
read -p "User ID/username: " username
#echo " Password  :"
#read -s password
read -p "Password: " password
read -p "Any hints :" hints
#update last_update = $time
echo "updated on = $last_updated"

cat >> $database <<EOF
 $nickname:$username:$password:$hints:$last_updated

EOF

# Encrypt the database after using
bash $ipath/src/encrypt.sh -en $database
echo " Entry has been registred successfully."

#print_close
#-------------------------------------------------#
# <==========Anji Babu Kapakayala===========>
#-------------------------------------------------#
