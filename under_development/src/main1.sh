#---------------------------------------------------------------#
#     <====================== KEYS ====================>
#---------------------------------------------------------------#
# "Keys" is a tool for managing your Passwords at one place.
#
# Authour: Anji Babu Kapakayala
#          IIT Kanpur, India.
#          anjibabu480@gmail.com
#
# Description:
#
#  "Keys" is a password manager to help a user to store and organize
#   passwords. Keys manages and stores the passwords encrypted and 
#   locally, requiring the user to create a master password: a single,
#   strong password  which  grants the user access to their entire
#   password database. Keys protects the user's data using the 
#   AES-256-cbc encryption with salted format.
#
#!/bin/bash
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
#---> Necessary directories and files.
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
#recovery=$HOME/.keys/etc/profile/recovery
#database=$HOME/.keys/etc/Database/database
#master_file=$HOME/.keys/etc/profile/masterkey
#install_file=$HOME/.keys/etc/path/install_path

#---------------------------------------------#
function print_welcome() {
cat << EOF
#------------------------------------------------------------#
$bold $blu  <=============== $rst $bold $red Welcome to Keys$rst $bold $blu ===============>$rst
#------------------------------------------------------------#

EOF
}
#-------------------------------------------------#
function header() {
cat << EOF

$bold $blu  <=============== $rst $bold $red Welcome to Keys$rst $bold $blu ===============>$rst
$bold <------------------------------------------------------------>$rst
 		    $bold $ylw $@ $rst

EOF
}
#-------------------------------------------------#
function print_close() {
cat << EOF

$bold <------------------------------------------------------------>$rst
EOF
}
#-------------------------------------------------#
# Purpose: Display pause prompt
# $1-> Message (optional)
function pause() {
local message="$@"
[ -z $message ] && message="$bold $blu Press [Enter] key to continue...$rst"
read -p "$message" readEnterKey
}
#-------------------------------------------------#
# When ever access this code ask for masterkey.
function get_master_key() {
# Decrypt 
bash $ipath/src/encrypt.sh -dm $master_file

master_key=`cat $master_file |awk '{print $1}'`
# Encrypt 
bash $ipath/src/encrypt.sh -em $master_file
}
#-------------------------------------------------#
# Access Installed directory 
function get_install_dir() {
#decrypt the file
ipath=`cat $install_path |awk '{print $1}'`
#enecrypt the file
#echo "$ipath"
}
#-------------------------------------------------#
function send_OTP() {
# if otp_key =1; OTP service ON
# if otp_key =0; OTP service OFF
 if [[ "$otp_key" == "1" ]];then
    OTP=$RANDOM
    echo "OTP to access Keys package: $OTP"|mutt -s " OTP " $user_mail &
    #echo "OTP to access Keys package: $1"|mutt -s " OTP for access Keys" $user_mail &
 fi
}
#---------------------------------------------#
# function to get user registered email.
function get_user_mail() {
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
# Enable OTP Service
function enable_OTP_service() {
 if [[ "$otp_key" == "1" ]];then
echo;echo "OTP service is alredy enabled.";echo
 else
#<---
    #decrypting the profile
    bash $ipath/src/encrypt.sh -dp $profile
cat > $profile <<EOF
 $user_name:$user_mail:$user_phn:1:1
EOF
#encrypting the profile
bash $ipath/src/encrypt.sh -ep $profile
#<--
   echo;echo "OTP service is enabled.";echo
fi
}
#-------------------------------------------------#
# Disable OTP Service
function disable_OTP_service() {
 if [[ "$otp_key" == "0" ]];then
   echo; echo "OTP service is alredy disabled."
 else
#<---
    #decrypting the profile
    bash $ipath/src/encrypt.sh -dp $profile
cat > $profile <<EOF
 $user_name:$user_mail:$user_phn:1:0
EOF
#encrypting the profile
bash $ipath/src/encrypt.sh -ep $profile
#<--
    echo;echo "OTP service is disabled.";echo
fi
}
#-------------------------------------------------#
# function to inform user when accessed the code
function inform_user() {
time=`date`
echo "Hi $user_name, You have accessed the Keys at $time."|mutt -s " Access alert!!" $user_mail &
}
#---------------------------------------------#
# function to inform user when accessed the code
function welcome_user() {
time=`date`
get_master_key
cat >> tmp << EOF
Hi $user_name,

Congratulations!, you have succesfully updated your profile with keys package.
It is recomended the user to remember the master key for accessing the password
database at off network times. 

Your masterkey: $master_key

Cheers!
Team,
Keys.
EOF
mutt -s " Welcome to Keys !!!" $user_mail < tmp &
rm tmp
}
#---------------------------------------------#
# function to inform user when updated the profile
function update_user() {
time=`date`
get_master_key
cat >> tmp << EOF
Hi $user_name,

you have succesfully updated your profile with keys package.
It is recomended the user to remember the master key for accessing the password
database at off network times. 

Your masterkey: $master_key

Cheers!
Team,
Keys.
EOF
mutt -s " Profile updated !!!" $user_mail < tmp &
rm tmp
}
#---------------------------------------------#
function uninstall() {
root=`id -u`
if [ $root -eq 0 ]; then           
  mv ${install_dir}/bin/keys ${install_dir}/src/keys.sh
  rm -rf ${install_dir}/.keys
  rm -rf ${install_dir}/bin
  sed -i "/KEYS/d" ~/.bashrc
  sed -i "/# Keys/d" ~/.bashrc
  echo "$bold $red Keys$rst: Unistalled the 'Keys' package."
  notify-send "Keys" "Keys has been uninstalled."
else
 not_root_user
fi
}
#-----------------------------------------------------#
function not_root_user() {
echo; echo "$bold $red Access denied.$rst"
 echo "$bold $red Uninstall as root user.$rst"
 exit 
}
#-----------------------------------------------------#
#     <===========MAIN CODE STARTS============>       #
#-----------------------------------------------------#
#print_welcome
get_install_dir
get_master_key
get_user_mail

#Print help without masterkey
case "$@" in
   -h|--help)bash $ipath/src/help_page.sh;exit;;
   -v|--version)echo "$bold$red Keys:$rst$bold$blu version 1.0.0$rst";exit;;
--recover-masterkey|--recover|-rc)
print_welcome
bash $ipath/src/recover_masterkey.sh
print_close;exit
;;
esac
#-----> 
  if [[ "$profile_key" == "0" ]];then
     case "$@" in
        --set-profile|-sp) 
#	print_welcome
        header "User registration"
	bash $ipath/src/set_user_profile.sh $profile_key
        get_user_mail
        welcome_user
	print_close;exit;; #mail user
     esac
  fi
#<-----
#if user mail acceble? if not, ask user to set profile first.
  if [[ "$profile_key" == "0" ]];then
#     echo "   <---------NOTICE------->"
     header "    WARNING "
     echo "$bold $red Keys$rst:$bold User has not been registered.$rst"
     echo "$bold $red Keys$rst:$bold Regiter using --set-profile tag.$rst"
     echo "$bold $red Keys$rst:$bold $grn keys --set-profile$rst";print_close;exit
  fi  
#---------------------------------------------#
#Ask user to enter masterkey
send_OTP
header ""
echo "$bold $red [ OTP has been sent to registered email. ]$rst";echo
for i in 1 2 3 ; do  # for setting up 3 attempts
read -s -p "$bold $ylw Enter OTP/masterkey:$rst " passwd
echo ""
#
if [[ "$passwd" != "" ]]; then
   if [ "$passwd" != "$OTP" ];then
      if [ "$passwd" == $master_key ] ;then
         echo "$bold $grn Access Granted !$rst"
         inform_user
         #clear;header
         break
      else
         echo "$bold $red Acces denied. May be Wrong Password entered.$rst"
         echo "$bold $ylw Try again $rst"
      fi
   else
      echo "$bold $grn Access Granted ! $rst"
      inform_user
      #clear;header
      break
   fi
else
    echo "$bold $red Acces denied. May be Wrong Password entered.$rst"
    echo "$bold $ylw Try again $rst"
fi
  if  [ "$i" -eq '3' ]
  then
     echo ""
     echo "=========================="
     echo "$bold $ylw Reached 3 attempts . Bye $rst"
     echo "=========================="
     notify-send "ALERT" "Failed to Access Your Passwords"
     exit
  fi
done
#---------------------------------------------#
#echo "No of Arguments:$#"
if [ $# -eq 0 ] ;then
#echo " Arguments $#"
while true;do
bash $ipath/src/list.sh
print_close

read -p "$bold$pur Enter nickname: $rst" nickname
   case "$nickname" in
     q|exit|quit)exit;;
   esac
#echo "You have selected $nickname"
bash $ipath/src/show_details.sh $nickname
pause
print_close
clear
done
else
case "$1" in
--nickname|-n)
#print_welcome
bash $ipath/src/show_details.sh $2
#print_close;;
;;
--enable-OTP)enable_OTP_service;;
--disable-OTP)disable_OTP_service;;
-ne|--new-entry)
bash $ipath/src/new_entry.sh;;
-ue|--update-entry)
bash $ipath/src/update_entry.sh ;;
-h|--help)
bash $ipath/src/help_page.sh;;
-l|list|--list)
bash $ipath/src/list.sh
#print_close
;;
-re|--remove-entry|--delete-entry)
bash $ipath/src/remove_entry.sh;;
--set-profile|-sp)
bash $ipath/src/set_user_profile.sh $profilekey
#print_close
;;
--update-profile)
bash $ipath/src/update_user_profile.sh
update_user
#print_close
;;
--reset-masterkey|-rmk)
bash $ipath/src/reset_masterkey.sh
#print_close
;;
--version|-v)
echo "Keys version 1.0.0";;
--uninstall|--clean)uninstall;;
*)echo;echo "$bold$red Keys:$rst $bold Not a valid argument.$rst"

esac
fi
print_close
#
#-----------------------------------------------------#
#     <===========MAIN CODE ENDS============>         #
#               Anji Babu Kapakaya 		      #
#-----------------------------------------------------#
