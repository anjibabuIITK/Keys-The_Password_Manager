#---------------------------------------------------------------#
#     <====================== KEYS ====================>
#---------------------------------------------------------------#
# "Keys" is a tool for managing your Passwords at one place.
#
# Authour: Anji Babu Kapakayala
#          IIT Kanpur, India.
#          anjibabu480@gmail.com
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

#Check .Password_Manager/etc/profile exists or not. if not create
path=$HOME/.keys/etc/profile
profile=$HOME/.keys/etc/profile/profile
recovery=$HOME/.keys/etc/profile/recovery
database=$HOME/.keys/etc/Database/database
master_file=$HOME/.keys/etc/profile/masterkey
install_file=$HOME/.keys/etc/path/install_path
[ -d $path ] ||mkdir -p $path
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
#------------------------------------------------------------#
$bold $blu  <=============== $rst $bold $red Welcome to Keys$rst $bold $blu ===============>$rst
#------------------------------------------------------------#
 		    $bold $ylw $@ $rst

EOF
}
#-------------------------------------------------#
function print_close() {
cat << EOF
#------------------------------------------------------------#

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
bash $ipath/src/encrypt.sh -de $master_file

master_key=`cat $master_file |awk '{print $1}'`
# Encrypt 
bash $ipath/src/encrypt.sh -en $master_file
}
#-------------------------------------------------#
# Access Installed directory 
function get_install_dir() {
#decrypt the file
ipath=`cat $install_file |awk '{print $1}'`
#enecrypt the file
#echo "$ipath"
}
#-------------------------------------------------#
function send_OTP() {
# otp_key =1; OTP service ON
# otp_key =0; OTP service OFF
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
bash $ipath/src/encrypt.sh -de $profile
#echo "profile decrypted."
user_name=`cat $profile |cut -d ":" -f1`
user_mail=`cat $profile |cut -d ":" -f2`
profile_key=`cat $profile |cut -d ":" -f4`
otp_key=`cat $profile |cut -d ":" -f5`
# Encrypt 
bash $ipath/src/encrypt.sh -en $profile
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
    bash $ipath/src/encrypt.sh -de $profile
cat > $profile <<EOF
 $usr_name:$usr_mail:$phone_nmbr:1:1
EOF
#encrypting the profile
bash $ipath/src/encrypt.sh -en $profile
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
    bash $ipath/src/encrypt.sh -de $profile
cat > $profile <<EOF
 $usr_name:$usr_mail:$phone_nmbr:1:0
EOF
#encrypting the profile
bash $ipath/src/encrypt.sh -en $profile
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
function uninstall() {
mv bin/keys src/keys.sh
rm -rf ~/.keys
rm -rf bin
sed -i "/KEYS/d" ~/.bashrc
sed -i "/# Keys/d" ~/.bashrc
echo " Keys: Unistalled the 'Keys' package."
notify-send "Keys" "Keys has been uninstalled."
}
#-----------------------------------------------------#
#  <===========MAIN CODE STARTS============>  #
#---------------------------------------------#
#print_welcome
get_install_dir
get_master_key
get_user_mail

#Print help without masterkey
case "$@" in
   -h|--help)bash $ipath/src/help_page.sh;exit;;
   -v|--version)echo "Keys: version 1.0.0";exit;;
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
	bash $ipath/src/set_user_profile.sh
        get_user_mail
        welcome_user
	print_close;exit;; #mail user
     esac
  fi
#<-----
#if user mail acceble? if not, ask user to set profile first.
  if [[ "$profile_key" == "0" ]];then
#     echo "   <---------NOTICE------->"
     header " NOTICE  "
     echo "Keys: User has not been registered."
     echo "Keys: Regiter using --set-profile tag."
     echo "Keys: keys --set-profile";print_close;exit
  fi  
#---------------------------------------------#
#Ask user to enter masterkey
send_OTP
echo "$bold $red [ OTP has been sent to registered email. ]$rst";echo
for i in 1 2 3  # for setting up 3 attempts
do
read -s -p "$bold $ylw Enter OTP/masterkey:$rst " passwd
echo ""
#
if [ "$passwd" != "$OTP" ];then
    if [ "$passwd" == $master_key ] ;then
        echo " $bold $red Access Granted !$rst"
        inform_user
        break
    else
    echo "$bold $red Acces denied. May be Wrong Password entered.$rst"
    echo "$bold $red Try again $rst"
   fi
else
echo "$bold $pur Access Granted ! $rst"
inform_user
#echo "$bold $pur Conti..$rst" 
break
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
#echo "Exit status from line:154";exit
#---------------------------------------------#
#echo "Enter Master Key: "
#read -s user_entered_key
#  if [[ "$user_entered_key" == "$master_key" ]];then
#     echo "Access Granted." 
#-----#
#echo "No of Arguments:$#"
if [ $# -eq 0 ] ;then
#echo " Arguments $#"
while true;do
print_welcome
bash $ipath/src/list.sh
print_close

read -p "Enter nickname: " nickname
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
case "$@" in
--enable-OTP)enable_OTP_service;;
--disable-OTP)disable_OTP_service;;
-ne|--new-entry)echo "New entry"
bash $ipath/src/new_entry.sh;;
-ue|--update-entry)echo "Update Entry"
bash $ipath/src/update_entry.sh ;;
-h|--help) echo "Asking Help"
bash $ipath/src/help_page.sh;;
-l|list|--list)
print_welcome
bash $ipath/src/list.sh
print_close
;;
-re|--remove-entry|--delete-entry)echo "Delete the entry"
bash $ipath/src/remove_entry.sh;;
--set-profile|-sp)
print_welcome
bash $ipath/src/set_user_profile.sh
print_close
;;
--update-profile)
print_welcome
bash $ipath/src/update_user_profile.sh
print_close
;;
--reset-masterkey|-rmk)
print_welcome
bash $ipath/src/reset_masterkey.sh
print_close
;;
--version|-v)
echo "Keys version 1.0.0";;
--uninstall|--clean)uninstall;;
*)echo "Not a valid argument."

esac
fi

# masterkey condirion
#else
#   echo "Entered wrong password." 
#   exit
#fi
