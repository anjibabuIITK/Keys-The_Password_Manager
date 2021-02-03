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
mail_key=${install_dir}/.keys/etc/profile/mail
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
# function to get user registered email.
function get_user_data() {
# Decrypt 
bash $ipath/src/encrypt.sh -dp $profile
#echo "profile decrypted."
user_name=`cat $profile |cut -d ":" -f1`
user_mail=`cat $profile |cut -d ":" -f2`
user_phn=`cat $profile |cut -d ":" -f3`
profile_key=`cat $profile |cut -d ":" -f4`
otp_key=`cat $profile |cut -d ":" -f5`
# Encrypt 
bash $ipath/src/encrypt.sh -ep $profile
#echo "profile encrypted."
}
#-------------------------------------------------#
function Print_present_data() {
echo;echo "$bold$ylw   Current User Profile: $rst"
echo "$bold$grn   Name  : $rst" $user_name
echo "$bold$grn   Email : $rst" $user_mail
echo "$bold$grn   Mobile: $rst" $user_phn
}
#-------------------------------------------------#
function update_profile() {
echo
read -p "$bold$red   Are you sure to update profile? [$rst${bold}yes/no$rst$bold$red]: $rst" option
#echo "$option"
if [[ "$option" == "yes" ]];then
#----> Setting user profile
echo;echo "$bold$ylw   Updating user profile:$rst";echo
#-->Name
while true;do
read -p "$bold$pur   Name : $rst" usr_name_new
 [ "$usr_name_new" == "" ] && echo "$bold$red   Keys:$rst $bold Empty Name is not allowed$rst"||break
done
#-->Email
while true;do
read -p "$bold$pur   Email: $rst" usr_mail_new
 [ "$usr_mail_new" == "" ] && echo "$bold$red   Keys:$rst $bold Empty Email is not allowed$rst"||break
done
#-->Phone Number is optonal
#while true;do
read -p "$bold$pur   Mobile:$rst" phone_nmbr_new
# [ "$phone_nmbr_new" == "" ] && echo "$bold$red   Keys:$rst $bold Empty Phone number is not allowed$rst"||break
#done
#decrypting the profile
bash $ipath/src/encrypt.sh -dp $profile
cat > $profile <<EOF
 $usr_name_new:$usr_mail_new:$phone_nmbr_new:1:$otp_key
EOF
#encrypting the profile
bash $ipath/src/encrypt.sh -ep $profile
#<--
echo;echo "$bold${red}   Keys:$rst${bold}Successfully updated the user profile.$rst"
else
echo;echo "$bold${red}   Keys:$rst${bold}Choosed to be not to update profile.$rst";exit
fi
echo""
}
#-------------------------------------------------#
function reset_recovery_data() {
#----> Recovery options
read -p "$bold${red}   Do you want to update recovery questions? [$rst${bold}yes/no$rst$bold$red]:$rst " option
#echo "$option"
if [[ "$option" == "yes" ]];then
echo;echo "$bold$ylw   Updating recovery Questions : $rst" ;echo
Q1="What is your Date of Birth [dd-mm-yyyy] ?"
#echo "$Q1"
Q2="What is your favorite place ?"
#echo "$Q2"
#--->Q1
while true;do
read -p "$bold$pur   What is your Date of Birth [dd-mm-yyyy] ?: $rst" QA1
 [ "$QA1" == "" ] && echo "$bold$red   Keys:$rst $bold Empty Answer is not allowed$rst"||break
done
#--->Q2
while true;do
read -p "$bold$pur   What is your favorite place ?: $rst" QA2
 [ "$QA2" == "" ] && echo "$bold$red   Keys:$rst $bold Empty Answer is not allowed$rst"||break
done
#-->
#decrypting the recovery file
bash $ipath/src/encrypt.sh -dr $recovery
cat > $recovery <<EOF
1:$Q1:$QA1:$Q2:$QA2
EOF
#encrypting the recovery file
bash $ipath/src/encrypt.sh -er $recovery
#<--
echo;echo "$bold$red   Keys:$rst$bold Recovery Questions has been updated.$rst"
else
echo;echo "$bold$red   Keys:$rst$bold Recovery Questions has been not updated.$rst"
fi
}
#---------------------------------------------#
#   <==========MAIN CODE STARTS========>
#---------------------------------------------#
get_user_data
Print_present_data
update_profile
reset_recovery_data
echo
#---------------------------------------------#
#  <===========ANJI BABU KAPAKAYALA=====>
#---------------------------------------------#
