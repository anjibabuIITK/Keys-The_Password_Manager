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
# <=================Main code==================>
#-------------------------------------------------#
# Decrypt the database before using
bash $ipath/src/encrypt.sh -de $database
last_updated=$(date +"%D ")
#print_welcome
read -p "Give  nickname:" nickname
a=`grep " $nickname:" $database`
if [ $? -eq 0 ]
then
echo "Present Details:"
# Encrypting the database
bash $ipath/src/encrypt.sh -en $database
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
bash $ipath/src/encrypt.sh -de $database
# Removing old entry
sed -i "/$nickname:/d" $database

# Updating new entry
cat >> $database <<EOF
 $nickname:$username:$password:$hints:$last_updated

EOF
# Encrypting the database
bash $ipath/src/encrypt.sh -en $database

echo "$nickname updated successfully.";echo

else
echo ""
echo "Nickname doesn't exist in database."
echo ""
fi

print_close
#-------------------------------------------------#
