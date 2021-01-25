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
last_updated=$(date +"%D ")
#print_welcome
read -p "Give  nickname:" nickname
a=`grep " $nickname:" $database`
if [ $? -eq 0 ]
then
echo "Present Details:"
# Encrypting the database
bash $ipath/src/encrypt.sh -ed $database
bash $ipath/src/show_details.sh $nickname

# Updating Database
echo " Enter New Deatils:"
read -p "User ID/username: " username
#echo " Password  :"
#read -s password
read -p "Password: " password
read -p "Any hints :" hints
#echo "updated on = $last_updated"

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

echo "$nickname updated successfully.";echo

else
echo ""
echo "Nickname doesn't exist in database."
# Encrypting the database
bash $ipath/src/encrypt.sh -ed $database
echo ""
fi

print_close
#-------------------------------------------------#
