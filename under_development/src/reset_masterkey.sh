#---------------------------------------------#
#    <=============KEYS=============>
#---------------------------------------------#
# This code is a part of Keys tool
#---------------------------------------------#
#!/bin/bash
#---------------------------------------------#
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
#path=$HOME/.keys/etc/profile
#profile=$HOME/.keys/etc/profile/profile
#database=$HOME/.keys/etc/Database/database
#master_file=$HOME/.keys/etc/profile/masterkey
#install_file=$HOME/.keys/etc/path/install_path
#ipath=`cat $install_file |awk '{print $1}'`
#[ -d $path ] ||mkdir -p $path
#---------------------------------------------#
# When ever access this code ask for masterkey.
function get_master_key() {
#decrypting the masterkey
bash $ipath/src/encrypt.sh -dm $master_file
master_key=`cat $master_file |awk '{print $1}'`
#enecrypting the masterkey
bash $ipath/src/encrypt.sh -em $master_file
#echo "$master_key"
}
#---------------------------------------------#
function reset_master_key() {
read -p "  Are you sure to reset Master Key [yes/no]: " option
#echo "$option"
if [[ "$option" == "yes" ]];then
echo "   Resetting Master Key: "
echo "   Enter New Master key: "
read -s  master_key
#decrypting the masterkey
bash $ipath/src/encrypt.sh -dm $master_file
cat > $master_file <<EOF
$master_key
EOF
#enecrypting the masterkey
bash $ipath/src/encrypt.sh -em $master_file
else
echo "   Master Key has not updated."
fi

#bash src/encrypt.sh -en $path/profile
}
#---------------------------------------------#
#    <==========Main code=========>
#---------------------------------------------#
get_master_key
#Ask user to enter masterkey
echo ;echo "  Enter Present Master Key: "
read -s user_entered_key

if [[ "$user_entered_key" == "$master_key" ]];then
   echo "   Access Granted." 
   reset_master_key
echo "   Master Key has been updated successfully."
else
   echo "   Entered wrong password." 
   exit
fi
#---------------------------------------------#
#    <==========ANJI BABU KAPAKAYALA========>
#---------------------------------------------#
