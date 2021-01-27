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
# Defining text colors
red=`tput setaf 1`
grn=`tput setaf 2`
ylw=`tput setaf 3`
blu=`tput setaf 4`
pur=`tput setaf 5`
rst=`tput sgr0`
bold=`tput bold`
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
bash $ipath/src/encrypt.sh -dm $master_file
master_key=`cat $master_file |awk '{print $1}'`
#encrypting the masterkey
bash $ipath/src/encrypt.sh -em $master_file
}
#---------------------------------------------#
function set_profile() {
#----> Setting user profile
#echo;echo " User Registration: "
echo "$bold$ylw User Profile:$rst";echo
#--->name
while true;do
read -p "$bold $pur  Name  :$rst " usr_name
 [ "$usr_name" == "" ] && echo "$bold$red   Keys:$rst $bold Empty Name is not allowed$rst"||break
done
#--->mail
while true;do
read -p "$bold $pur  Email :$rst " usr_mail
 [ "$usr_mail" == "" ] && echo "$bold$red   Keys:$rst $bold Empty Mail is not allowed$rst"||break
done
#--->mobile is optional
read -p "$bold $pur  Mobile:$rst " phone_nmbr

#--> Asking for OTP service
echo;echo "$bold$ylw OTP Service :$rst";echo
#read -p " Want to enable OTP service ?[yes/no]: " option1
read -p "$bold $pur  Enable OTP service ?[yes/no]:$rst " option1
[ "$option1" == "" ] && option1="no"
if [[ "$option1" == "yes" ]];then
otp_key=1
echo "$bold $red  Keys:$rst $bold OTP service has been enabled. $rst"
else
otp_key=0
echo "$bold $red  Keys:$rst $bold OTP service is desabled. $rst"
fi
#<---
echo
#decrypting the profile
bash $ipath/src/encrypt.sh -dp $profile
cat > $profile <<EOF
 $usr_name:$usr_mail:$phone_nmbr:1:$otp_key
EOF
#encrypting the profile
bash $ipath/src/encrypt.sh -ep $profile
#<--
#----> Setting Masterkey
echo "$bold$ylw Master Key  :$rst";echo
while true;do
read -p "$bold$pur   Master Key :$rst " master_key
 [ "$master_key" == "" ] && echo "$bold$red   Keys:$rst $bold Master key is mandatory to access the database.$rst"||break
#if [[ "$option" == "yes" ]];then
#echo " Setting the Master Key: "
#read -p "Enter Master key:" master_key
#-->
done
#decrypting the master_file
bash $ipath/src/encrypt.sh -dm $master_file
cat > $master_file <<EOF
$master_key
EOF
#encrypting the master_file
bash $ipath/src/encrypt.sh -em $master_file
#<--
#else
#echo " Master Key has been set to default."
#echo " Default masterkey is 123456"
#fi
echo""
#----> Recovery options
echo "$bold$ylw Recovery Questions:$rst";echo
#echo " Setting recovery Questions : " 
Q1="What is your Date of Birth [dd-mm-yyyy] ?"
#echo "$Q1"
Q2="What is your favorite place ?"
#echo "$Q2"
while true;do
read -p "$bold$pur   What is your Date of Birth [dd-mm-yyyy] ?:$rst " QA1
 [ "$QA1" == "" ] && echo "$bold$red   Keys:$rst $bold Recovery Questions are mandatory to recover the master key.$rst"||break
done
echo
while true;do
read -p "$bold$pur   What is your favorite place ?: $rst" QA2
 [ "$QA2" == "" ] && echo "$bold$red   Keys:$rst $bold Recovery Questions are mandatory to recover the master key.$rst"||break
done
#-->
#decrypting the master_file
bash $ipath/src/encrypt.sh -dr $recovery
cat > $recovery <<EOF
1:$Q1:$QA1:$Q2:$QA2
EOF
#encrypting the master_file
bash $ipath/src/encrypt.sh -er $recovery
#<--
#echo " Recovery Questions has been updated."
}
#---------------------------------------------#
#   <==========MAIN CODE STARTS========>
#---------------------------------------------#
#get_master_key
# Ask user to set profile
if [[ "$1" == "0" ]];then
set_profile
echo;echo "$bold$red   Keys:$rst $bold User has been registered successfully. $rst"
else
echo;echo
echo "$bold$red Keys:$rst $bold User already registred.$rst"
echo "$bold$red Keys:$rst $bold Use $bold$grn keys --update-profile$rst $bold to update$rst"
echo""
fi
#---------------------------------------------#
#  <===========ANJI BABU KAPAKAYALA=====>
#---------------------------------------------#
