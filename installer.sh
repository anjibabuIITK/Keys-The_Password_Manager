# Configuration file to install password manager
#!/bin/bash
#-------------------------------------------------#
function check_toilet() {
a=`which toilet`
if [ "$?" == "0" ];then
echo " Keys: toilet -----> Found."
else
#apt-get -y install toilet
#echo " Keys: toilet has been installed."
echo " Keys: toilet -----> Not found.";exit
fi
}
#-------------------------------------------------#
function check_mutt() {
b=`which mutt`
if [ "$?" == "0" ];then
echo " Keys: mutt -----> Found."
#configure mutt
else
#apt-get -y install mutt
#echo " Keys: mutt has been installed."
echo " Keys: [ERROR] mutt -----> Not found. [ Istall mutt for reciving OTP service ]"
exit
fi
}
#-------------------------------------------------#
function check_dependencies() {
b=`which sed`
if [ "$?" == "0" ];then
echo " Keys: sed -----> Found."
else
#apt-get -y install sed
#echo " Keys: sed has been installed."
echo " Keys: [ERROR] sed -----> Not found.";exit
fi
#
c=`which awk`
if [ "$?" == "0" ];then
echo " Keys: awk -----> Found."
else
#apt-get -y install awk
#echo " Keys: awk has been installed."
echo " Keys: [ERROR] awk -----> Not found.";exit
fi
#
d=`which notify-send`
if [ "$?" == "0" ];then
echo " Keys: notify-send -----> Found."
else
#apt-get -y install notify-send
#echo " Keys: send-notify has been installed."
echo " Keys: [warning] notify-send -----> Not found."
fi
#
d=`which grep`
if [ "$?" == "0" ];then
echo " Keys: grep -----> Found."
else
#apt-get -y install grep
#echo " Keys: grep has been installed."
echo " Keys: [Error] grep -----> Not found.";exit
fi
#
d=`which openssl`
if [ "$?" == "0" ];then
echo " Keys: openssl -----> Found."
else
#apt-get -y install grep
#echo " Keys: grep has been installed."
echo " Keys: [Error] openssl -----> Not found. [Please install openssl]";exit
fi
#
}
#-------------------------------------------------#
function make_directories() {
mkdir -p $HOME/.keys/etc/Database
mkdir -p $HOME/.keys/etc/path
mkdir -p $HOME/.keys/etc/profile
profile=$HOME/.keys/etc/profile/profile
database=$HOME/.keys/etc/Database/database
install_path=$HOME/.keys/etc/path/install_path
master_file=$HOME/.keys/etc/profile/masterkey
initial_key=123456
#create empty profile and encrypt
touch $profile
bash src/encrypt.sh -en $profile
cat >$database<<EOF
-NA-
EOF
#encrypting database
bash src/encrypt.sh -en $database
cat > $master_file <<EOF
$initial_key
EOF
#encrypting masterkey
bash src/encrypt.sh -en $master_file
echo " Keys: Created required directories."
}
#-----------------------------------------------------#
function not_root_user() {
echo; echo "Access denied."
 echo " Install as root user."
 exit 
}
#-----------------------------------------------------#
function update_bashrc() {
cat >> $HOME/.bashrc <<EOF
# Keys (the password manager)
#export KEYS=\$KEYS:$install_dir/bin
export PATH=\$PATH:$install_dir/bin #KEYS
EOF
echo " Keys: Updated the ~/.bashrc."
}
#-----------------------------------------------------#
function install_package() {
install_dir=`pwd`
install_path=$HOME/.keys/etc/path/install_path
cp src/main1.sh .
chmod 777 main1.sh
mkdir bin
mv main1.sh bin/keys
cat > $install_path <<EOF
$install_dir
EOF
echo " Keys: Updated install path."

echo " Keys: Installed the 'Keys' package."
}
#-----------------------------------------------------#
function uninstall() {
mv bin/keys src/keys.sh
rm -rf ~/.keys
rm -rf bin
sed -i "/KEYS/d" ~/.bashrc
sed -i "/# Keys/d" ~/.bashrc
echo " Keys: Unistalled the 'Keys' package."
}
#-----------------------------------------------------#
#   <=============MAIN CODE STARTS=============>
#-----------------------------------------------------#
root=`id -u`
if [ $# -eq 0 ] ;then
#if [ $root -eq 0 ]; then           
  check_toilet
  check_mutt
  make_directories
  check_dependencies
  install_package
  update_bashrc
#else
#not_root_user
#fi
else
  case "$@" in
  uninstall|clean)uninstall;;
  *)echo " Not a valid argument.";echo
  esac
fi
#-----------------------------------------------------#
#   <===========Anji Babu Kapakayala============>
#-----------------------------------------------------#
