#---------------------------------------------#
# This code is a part of Keys tool
#---------------------------------------------#
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
# When ever access this code ask for masterkey.
function get_master_key() {
#decrypting the masterkey
bash $ipath/src/encrypt.sh -de $master_file
master_key=`cat $master_file |awk '{print $1}'`
#encrypting the masterkey
bash $ipath/src/encrypt.sh -en $master_file
}
#---------------------------------------------#
function set_profile() {
echo;echo " User Registration: "
read -p "Name : " usr_name
read -p "Email: " usr_mail
read -p "Phone Number:" phone_nmbr

#-->
#decrypting the profile
bash $ipath/src/encrypt.sh -de $profile
cat > $profile <<EOF
 $usr_name:$usr_mail:$phone_nmbr
EOF
#encrypting the profile
bash $ipath/src/encrypt.sh -en $profile
#<--

read -p " Want to reset Master Key ?[yes/no]: " option
#echo "$option"
if [[ "$option" == "yes" ]];then
echo " Resetting Master Key: "
read -p "Enter Master key:" master_key
#-->
#decrypting the master_file
bash $ipath/src/encrypt.sh -de $master_file
cat > $master_file <<EOF
$master_key
EOF
#encrypting the master_file
bash $ipath/src/encrypt.sh -en $master_file
#<--
else
echo " Master Key has not changed."
fi
}
#---------------------------------------------#
#   <==========MAIN CODE STARTS========>
#---------------------------------------------#
#get_master_key
# Ask user to set profile
set_profile
echo;echo " User has been registered successfully. "
#---------------------------------------------#
#  <===========ANJI BABU KAPAKAYALA=====>
#---------------------------------------------#
