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
echo;echo "$bold$ylw  Resetting Master Key: $rst"
echo;read -p "$bold$red  Are you sure to reset Master Key [$rst${bold}yes/no$rst$bold$red]: $rst" option
#echo "$option"
if [[ "$option" != "" ]]; then
   if [[ "$option" == "yes" ]];then
     while true;do
      echo "$bold$pur  Enter New Master key: $rst"
      read -s  master_key
        if [[ "$master_key" != "" ]]; then
      #decrypting the masterkey
      bash $ipath/src/encrypt.sh -dm $master_file
cat > $master_file <<EOF
$master_key
EOF
     #enecrypting the masterkey
     bash $ipath/src/encrypt.sh -em $master_file
    echo;echo "$bold$red  Keys:$rst$bold  Master Key has been updated.$rst"
       break
       else
       echo;echo "$bold$red  Keys:$rst$bold Empty Master Key is NOT allowed.$rst"
       fi
     done
   else
    echo;echo "$bold$red  Keys:$rst$bold  Master Key has not updated.$rst"
   fi
else
     echo;echo "$bold$red  Keys:$rst$bold  Master Key has not updated.$rst"

fi
}
#---------------------------------------------#
#    <==========Main code=========>
#---------------------------------------------#
get_master_key
reset_master_key
#Ask user to enter masterkey
#echo ;echo "  Enter Present Master Key: "
#read -s user_entered_key

#if [[ "$user_entered_key" == "$master_key" ]];then
#   echo "   Access Granted." 
#   reset_master_key
#echo "   Master Key has been updated successfully."
#else
#   echo "   Entered wrong password." 
#   exit
#fi
#---------------------------------------------#
#    <==========ANJI BABU KAPAKAYALA========>
#---------------------------------------------#
