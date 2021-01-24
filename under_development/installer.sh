#---------------------------------------------------------------#
#     <====================== KEYS ====================>
#---------------------------------------------------------------#
# "Keys" is the tool for managing your Passwords at one place.
#
# Authour: Anji Babu Kapakayala
#          IIT Kanpur, India.
#          anjibabu480@gmail.com
# 
#
# Description:
# This is a configuration file to install and setup environment for Keys.
# This file can execute as root. It also attempt to install required 
# dependencies.
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
#!/bin/bash
#-------------------------------------------------#
function check_toilet() {
a=`which toilet`
if [ "$?" == "0" ];then
echo "$bold $grn Keys$rst: toilet -----> Found."
else
apt-get -y install toilet
echo "$bold $grn Keys$rst: toilet has been installed."
#echo " Keys: toilet -----> Not found.";exit
fi
}
#-------------------------------------------------#
function check_mutt() {
b=`which mutt`
if [ "$?" == "0" ];then
echo "$bold $grn Keys$rst: mutt -----> Found."
configure_mutt
else
apt-get -y install mutt
configure_mutt
echo "$bold $grn Keys$rst: mutt has been installed."
echo "$bold $grn Keys$rst: mutt has been configured."
#echo " Keys: [ERROR] mutt -----> Not found. [ Istall mutt for reciving OTP service ]"
#exit
fi
}
#-------------------------------------------------#
function configure_mutt() {
mkdir -p $HOME/.mutt/cache
cat > $HOME/.muttrc<<EOF
# ------------------------------------------#
#   <==============Keys=================>
# ------------------------------------------#
set from = "keys.package@gmail.com"
set realname = "Keys"
set imap_user = "keys.package@gmail.com"
set imap_pass = "iitkanpur"
set folder = "imaps://imap.gmail.com:993"
set spoolfile = "+INBOX"
set postponed ="+[Gmail]/Drafts"
set header_cache =~/.mutt/cache/headers
set message_cachedir =~/.mutt/cache/bodies
set certificate_file =~/.mutt/certificates
set smtp_url = "smtp://keys.package@smtp.gmail.com:587/"
set smtp_pass = "iitkanpur"
set move = no
set imap_keepalive = 900
# ------------------------------------------#
EOF
}
#-------------------------------------------------#
function check_dependencies() {
#--->sed
b=`which sed`
if [ "$?" == "0" ];then
echo "$bold $grn Keys$rst: sed -----> Found."
else
apt-get -y install sed
echo "$bold $grn Keys$rst: sed has been installed."
#echo " Keys: [ERROR] sed -----> Not found.";exit
fi
#--->awk
c=`which awk`
if [ "$?" == "0" ];then
echo "$bold $grn Keys$rst: awk -----> Found."
else
apt-get -y install awk
echo "$bold $grn Keys$rst: awk has been installed."
#echo " Keys: [ERROR] awk -----> Not found.";exit
fi
#--->notify-send
d=`which notify-send`
if [ "$?" == "0" ];then
echo "$bold $grn Keys$rst: notify-send -----> Found."
else
apt-get -y install notify-send
echo "$bold $grn Keys$rst: send-notify has been installed."
#echo " Keys: [warning] notify-send -----> Not found."
fi
#--->grep
d=`which grep`
if [ "$?" == "0" ];then
echo "$bold $grn Keys$rst: grep -----> Found."
else
apt-get -y install grep
echo "$bold $grn Keys$rst: grep has been installed."
#echo " Keys: [Error] grep -----> Not found.";exit
fi
#--->cat
d=`which cat`
if [ "$?" == "0" ];then
echo "$bold $grn Keys$rst: cat -----> Found."
else
apt-get -y install cat 
echo "$bold $grn Keys$rst: cat has been installed."
#echo " Keys: [Error] cat -----> Not found.";exit
fi
#--->openssl
d=`which openssl`
if [ "$?" == "0" ];then
echo "$bold $grn Keys$rst: openssl -----> Found."
else
apt-get -y install openssl
echo "$bold $grn Keys$rst: openssl has been installed."
#echo " Keys: [Error] openssl -----> Not found. [Please install openssl]";exit
fi
#
}
#-------------------------------------------------#
function make_directories() {
install_dir=`pwd`
user=`pwd|cut -d "/" -f3`
KEY="${install_dir}/.keys"
etc="${install_dir}/.keys/etc"
Database_d=${install_dir}/.keys/etc/Database
Profile_d=${install_dir}/.keys/etc/profile
path_d=${install_dir}/.keys/etc/path

profile=${install_dir}/.keys/etc/profile/profile
recovery=${install_dir}/.keys/etc/profile/recovery
database=${install_dir}/.keys/etc/Database/database
install_path=${install_dir}/.keys/etc/path/install_path
master_file=${install_dir}/.keys/etc/profile/masterkey
initial_key=123456

#create empty profile and encrypt
mkdir -p $KEY $etc $Database_d $Profile_d $path_d
touch $profile $recovery $database $install_path $master_file


#----->
cat >$profile<<EOF
 :::0:0
EOF
bash src/encrypt.sh -en $profile
#----->
cat >$database<<EOF
Press--->q-->to-exit.
EOF
#encrypting database
bash src/encrypt.sh -en $database
#--->
cat > $master_file <<EOF
$initial_key
EOF
#encrypting masterkey
bash src/encrypt.sh -en $master_file
#
cat > $recovery <<EOF
0::::
EOF
#encrypting recovery file
bash src/encrypt.sh -en $recovery

#---> Changing ownership to user
chown -R $user:$user $KEY
chown -R $user:$user $profile.key
chown -R $user:$user $master_file.key
chown -R $user:$user $recovery.key
chown -R $user:$user $database.key
chown -R $user:$user $install_path
echo "$bold $grn Keys$rst: Created database."
echo "$bold $grn Keys$rst: Created required directories and files"
}
#-----------------------------------------------------#
function not_root_user() {
echo; echo "$bold $red Access denied.$rst"
 echo "$bold $red Install as root user.$rst"
 exit 
}
#-----------------------------------------------------#
function update_bashrc() {
cat >> $HOME/.bashrc <<EOF
# Keys (the password manager)
export KEYS_INSTALL_DIR=$install_dir
export PATH=\$PATH:$install_dir/bin #KEYS
EOF
echo "$bold $grn Keys$rst: Updated the ~/.bashrc."
}
#-----------------------------------------------------#
function install_package() {
install_dir=`pwd`
install_path=${install_dir}/.keys/etc/path/install_path
cp src/main1.sh .
chmod 777 main1.sh
mkdir bin
mv main1.sh bin/keys
cat > $install_path <<EOF
$install_dir
EOF
echo "$bold $grn Keys$rst: Updated install path."

echo "$bold $grn Keys$rst: Successfully installed the 'Keys' package. "
}
#-----------------------------------------------------#
function uninstall() {
install_dir=`pwd`
mv bin/keys src/keys.sh
rm -rf ${install_dir}/.keys
rm -rf bin
sed -i "/KEYS/d" ~/.bashrc
sed -i "/# Keys/d" ~/.bashrc
echo "$bold $red Keys$rst: Unistalled the 'Keys' package."
}
#-----------------------------------------------------#
#   <=============MAIN CODE STARTS=============>
#-----------------------------------------------------#
root=`id -u`
if [ $root -eq 0 ]; then           
   if [ $# -eq 0 ] ;then
  	check_toilet
  	check_mutt
	make_directories
  	check_dependencies
  	install_package
  	update_bashrc
  	notify-send " Keys" "Keys has been installed successfully."
   else
      case "$@" in
      uninstall|clean|cl)uninstall
      notify-send "Keys" "Keys has been uninstalled.";;
      *)echo "$bold $red Not a valid argument.$rst";echo
      esac
   fi
else
 not_root_user
fi
#-----------------------------------------------------#
#   <===========Anji Babu Kapakayala============>
#-----------------------------------------------------#
