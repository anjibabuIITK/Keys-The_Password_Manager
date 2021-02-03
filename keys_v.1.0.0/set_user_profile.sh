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
function set_Auto_Backup_service() {
#setup autobackup_key=0
#--> Asking for Setup Auto Backup Service
echo;echo "$bold$ylw Auto Backup Service :$rst";echo
read -p "$bold $pur  Enable Auto Backup Service ?[$rst${bold}yes/no$rst$bold$pur]:$rst " option2
[ "$option2" == "" ] && option2="no"
if [[ "$option2" == "yes" ]];then
# Download rclone
q=`which rclone`
if [ "$?" != "0" ];then
curl -O https://downloads.rclone.org/rclone-current-linux-amd64.zip
unzip rclone-current-linux-amd64.zip
cd rclone-*-linu-amd64
#install rclone
sudo cp rclone /usr/bin/
sudo chown root:root /usr/bin/rclone
sudo chmod 755 /usr/bin/rclone
#Install manpage
sudo mkdir -p /usr/local/share/man/man1
sudo cp rclone.1 /usr/local/share/man/man1/
sudo mandb 
#
#Ref:https://rclone.org/install/
echo;echo "$bold$red Keys:$rst$bold rclone---> setup done.$rst"
fi
#---->
# configure rclone (mapping with gdrive)
echo;echo "$bold$ylw Auto Backup Service:$rst";echo
echo "$bold$red Copy and paste the bellow url in bowser and sign-in with your gmail, then enter the access code provided by Google.$rst"
sleep 3
rclone config create gdrive drive config_is_local false
#<----
  if [ "$?" == "0" ];then
#echo;read -p "$bold$red   Did you complted the above instructions? [$rst${bold}yes/no$rst$bold$red] :$rst "  answer
#  if [[ "$answer" == "yes" ]];then
  backup_key=1
#---> Setup Schedular for backup
  schedule_Autobackup
  echo "$bold $red  Keys:$rst $bold Auto Backup has been enabled. $rst"
  else
  backup_key=0
  echo "$bold $red  Keys:$rst $bold Auto backup is not enabled. Make sure you have followed above instructions to enable Auto Backup service. $rst"
  fi

update_mail_backupkeys $mailkey $backup_key
else
  backup_key=0
  echo "$bold $red  Keys:$rst $bold Auto Backup has NOT been enabled. $rst"
fi
}
#----------------------------------------#
# Installing crontab from script
#write out current crontab
function schedule_Autobackup() {
crontab -l > mycron
#echo new cron into cron file
echo "0 0 * * * keys --backup" >> mycron
#install new cron file
crontab mycron
rm mycron
}
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
function configure_mutt() {
mail=$1
paswd=$2
mail_usernam=`echo $mail|cut -d "@" -f1`
b=`which mutt`
if [ "$?" == "0" ];then
mkdir -p $HOME/.mutt/cache
cat > $HOME/.muttrc<<EOF
# ------------------------------------------#
#   <==============Keys=================>
# ------------------------------------------#
set from = "$mail"
set realname = "Keys"
set imap_user = "$mail"
set imap_pass = "$paswd"
set folder = "imaps://imap.gmail.com:993"
set spoolfile = "+INBOX"
set postponed ="+[Gmail]/Drafts"
set header_cache =~/.mutt/cache/headers
set message_cachedir =~/.mutt/cache/bodies
set certificate_file =~/.mutt/certificates
set smtp_url = "smtp://$mail_usernam@smtp.gmail.com:587/"
set smtp_pass = "$paswd"
set move = no
set imap_keepalive = 900
# ------------------------------------------#
EOF
#---> Prompt Instructions to Enable gmail settings
# Prompt_instructions
prompt_instructions
else
mailkey=0
echo "$bold$red Keys:$rst Could not find mutt package.$rst"
echo "$bold$red Keys:$rst sudo apt-get install mutt$rst"
fi
}
#------------------------------------------------------------------------#
function prompt_instructions() {
echo
cat <<EOF

$bold$ylw Gmail Setup :$rst

   1.$bold$red IMAP setup :$rst

   Login to gmail provided ($usr_mail), then click the gear icon on right corner to open Settings.
   Then enable IMAP Access in  Forwarding POP/IMAP options.
EOF
echo;read -p "$bold$red   Did you complted the above instructions? [$rst${bold}yes/no$rst$bold$red] :$rst "  answer
if [[ "$answer" == "yes" ]];then
echo;echo "$bold$ylw   IMAP setup --->$rst${bold}Done.$rst";echo
else
#otp_key=1
echo "$bold $red  Keys:$rst $bold Make sure you have followed above instructions to enable mailing service. $rst";echo
fi
cat <<EOF
   2.$bold$red SSL setup:$rst

   User need to provide the access rights to use smtp server to send mails.
   Therefore, turn ON the access to the less secure app from the Google account.

   Copy and Paste the following in google and login to your goole account and turn on the 
   access to the less secure app.

   $bold${red}link:$rst
   https://myaccount.google.com/lesssecureapps?rapt=AEjHL4O_kqNYY2u6Bx_T_9R2Yja9tkjiVA-ScsE2OvzT4lakWYRwZfSkLcBYKJ98DYfrLuEx_5VOKFrFyBJ4URzX5hfISIMLxA
EOF
sleep 5
xdg-open https://myaccount.google.com/lesssecureapps?rapt=AEjHL4O_kqNYY2u6Bx_T_9R2Yja9tkjiVA-ScsE2OvzT4lakWYRwZfSkLcBYKJ98DYfrLuEx_5VOKFrFyBJ4URzX5hfISIMLxA
echo;read -p "$bold$red   Did you complted the above instructions? [$rst${bold}yes/no$rst$bold$red] :$rst "  answer
  if [[ "$answer" == "yes" ]];then
  #otp_key=1
  mailkey=1
  echo "$bold $red  Keys:$rst $bold Mailing service has been enabled. $rst"
  else
#  otp_key=0
  mailkey=0
  echo "$bold $red  Keys:$rst $bold Make sure you have followed above instructions to enable mailing service. $rst"
  fi

}
#------------------------------------------------------------------------#
function set_master_key() {
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
}
#------------------------------------------------------------------------#
function set_recovery_questions() {
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
#------------------------------------------------------------------------#
function set_mailing_service() {
#--> Asking for Setup Mailing Service
echo;echo "$bold$ylw Mailing Service :$rst";echo
#read -p " Want to enable OTP service ?[yes/no]: " option1
read -p "$bold $pur  Enable Mailing Service ?[$rst${bold}yes/no$rst$bold$pur]:$rst " option1
[ "$option1" == "" ] && option1="no"
if [[ "$option1" == "yes" ]];then
# Ask for Gmail Password
# configure mutt here --> function to configure mutt with given details
# And make user to enable smtp service print instructions to setup mutt.
# send welcome mail here
while true;do
echo;read -s -p "$bold$pur   Password of gmail($rst$bold$usr_mail$rst$bold$pur)$rst ? :" gmail_passwd
 [ "$gmail_passwd" == "" ] && echo "$bold$red   Keys:$rst $bold Gmail password is required to setup automatic mailing service.$rst"||break
done
configure_mutt $usr_mail $gmail_passwd
mailkey=1
backup_key=0
update_mail_backupkeys $mailkey $backup_key
#echo "$bold $red  Keys:$rst $bold Mailing service has been enabled. $rst"
else
#otp_key=0
mailkey=0
echo "$bold $red  Keys:$rst $bold Mailing service is desabled. $rst"
fi
#<---
echo
}
#------------------------------------------------------------------------#
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
otp_key=0
profile_key=1
#decrypting the profile
bash $ipath/src/encrypt.sh -dp $profile
cat > $profile <<EOF
 $usr_name:$usr_mail:$phone_nmbr:$profile_key:$otp_key
EOF
#encrypting the profile
bash $ipath/src/encrypt.sh -ep $profile
#<--
echo
}
#---------------------------------------------#
function update_mail_backupkeys() {
#--->writing mailkey
mkey=$1
bkey=$2
#decrypting the profile
#bash $ipath/src/encrypt.sh -dp $mail_key
cat > $mail_key <<EOF
 $mkey:$bkey
EOF
#encrypting the profile
#bash $ipath/src/encrypt.sh -ep $profile
#<--
}
#---------------------------------------------#
#   <==========MAIN CODE STARTS========>
#---------------------------------------------#
#get_master_key
# profile_key=$1
# Ask user to set profile
if [[ "$1" == "0" ]];then
set_master_key
set_profile
set_recovery_questions
set_mailing_service
set_Auto_Backup_service
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
