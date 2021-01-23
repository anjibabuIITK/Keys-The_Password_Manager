#---------------------------------------------#
# This code is a part of Keys tool
#---------------------------------------------#
#!/bin/bash
#---------------------------------------------#
path=$HOME/.keys/etc/profile
profile=$HOME/.keys/etc/profile/profile
recovery=$HOME/.keys/etc/profile/recovery
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
set_profile
echo;echo " User has been registered successfully. "
#---------------------------------------------#
#  <===========ANJI BABU KAPAKAYALA=====>
#---------------------------------------------#