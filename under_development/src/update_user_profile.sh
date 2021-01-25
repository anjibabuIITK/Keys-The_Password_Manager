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
echo;echo "Current User Profile: "
echo "Name  : " $user_name
echo "Email : " $user_mail
echo "Mobile:" $user_phn

}
#-------------------------------------------------#
function update_profile() {

read -p " Are you sure to update profile? [yes/no]: " option
#echo "$option"
if [[ "$option" == "yes" ]];then
#----> Setting user profile
echo;echo " Updating user profile:";echo
read -p "Name : " usr_name_new
read -p "Email: " usr_mail_new
read -p "Mobile:" phone_nmbr_new

#decrypting the profile
bash $ipath/src/encrypt.sh -dp $profile
cat > $profile <<EOF
 $usr_name_new:$usr_mail_new:$phone_nmbr_new:1:$otp_key
EOF
#encrypting the profile
bash $ipath/src/encrypt.sh -ep $profile
#<--
echo "Successfully updated the user profile"
else
echo "Choosed to be not to update profile.";exit
fi
echo""
}
#-------------------------------------------------#
function reset_recovery_data() {
#----> Recovery options
read -p " Do you want to update recovery questions? [yes/no]: " option
#echo "$option"
if [[ "$option" == "yes" ]];then
echo " Setting recovery Questions : " 
Q1="What is your Date of Birth [dd-mm-yyyy] ?"
#echo "$Q1"
Q2="What is your favorite place ?"
#echo "$Q2"
read -p "What is your Date of Birth [dd-mm-yyyy] ?: " QA1
read -p "What is your favorite place ?: " QA2
#-->
#decrypting the recovery file
bash $ipath/src/encrypt.sh -dr $recovery
cat > $recovery <<EOF
1:$Q1:$QA1:$Q2:$QA2
EOF
#encrypting the recovery file
bash $ipath/src/encrypt.sh -er $recovery
#<--
echo " Recovery Questions has been updated."
else
echo " Recovery Questions has been not updated."
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
