#---------------------------------------------#
# This code is a part of Keys tool
#---------------------------------------------#
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
#recovery=$HOME/.keys/etc/profile/recovery
#database=$HOME/.keys/etc/Database/database
#master_file=$HOME/.keys/etc/profile/masterkey
#install_file=$HOME/.keys/etc/path/install_path
#ipath=`cat $install_file |awk '{print $1}'`
#[ -d $path ] ||mkdir -p $path
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
#----> Setting user profile
echo;echo " User Registration: "
read -p "Name : " usr_name
read -p "Email: " usr_mail
read -p "Phone Number:" phone_nmbr

#--> Asking for OTP service
read -p " Want to enable OTP service ?[yes/no]: " option1
if [[ "$option1" == "yes" ]];then
otp_key=1
echo " OTP service has been enabled. "
else
otp_key=0
echo " OTP service is desabled. "
fi
#<---
#decrypting the profile
bash $ipath/src/encrypt.sh -de $profile
cat > $profile <<EOF
 $usr_name:$usr_mail:$phone_nmbr:1:$otp_key
EOF
#encrypting the profile
bash $ipath/src/encrypt.sh -en $profile
#<--
#----> Setting Masterkey
read -p " Set Master Key ?[yes/no]: " option
#echo "$option"
if [[ "$option" == "yes" ]];then
echo " Setting the Master Key: "
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
echo " Master Key has been set to default."
echo " Default masterkey is 123456"
fi
echo""
#----> Recovery options
echo " Setting recovery Questions : " 
Q1="What is your Date of Birth [dd-mm-yyyy] ?"
#echo "$Q1"
Q2="What is your favorite place ?"
#echo "$Q2"
read -p "What is your Date of Birth [dd-mm-yyyy] ?: " QA1
read -p "What is your favorite place ?: " QA2
#-->
#decrypting the master_file
bash $ipath/src/encrypt.sh -de $recovery
cat > $recovery <<EOF
1:$Q1:$QA1:$Q2:$QA2
EOF
#encrypting the master_file
bash $ipath/src/encrypt.sh -en $recovery
#<--
echo " Recovery Questions has been updated."
}
#---------------------------------------------#
#   <==========MAIN CODE STARTS========>
#---------------------------------------------#
#get_master_key
# Ask user to set profile
if [[ "$1" == "0" ]];then
set_profile
echo;echo " User has been registered successfully. "
else
echo " User already registred."
echo " Use keys --update-profile to update"
echo""
fi
#---------------------------------------------#
#  <===========ANJI BABU KAPAKAYALA=====>
#---------------------------------------------#
