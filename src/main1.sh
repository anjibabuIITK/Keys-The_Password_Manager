# "Keys" is a tool for managing your Passwords at one place.
#
# Authour: Anji Babu Kapakayala
#          IIT Kanpur, India.
#
#
#!/bin/bash
#Check .Password_Manager/etc/profile exists or not. if not create
path=$HOME/.keys/etc/profile
file=$HOME/.keys/etc/profile/profile
database=$HOME/.keys/etc/Database/database
master_file=$HOME/.keys/etc/profile/masterkey
install_file=$HOME/.keys/etc/path/install_path
[ -d $path ] ||mkdir -p $path
#---------------------------------------------#
function print_welcome() {
cat << EOF
#------------------------------------------------------------#
#   <=============== Welcome to Keys ===============>	     # 
#------------------------------------------------------------#

EOF
}
#-------------------------------------------------#
function print_close() {
cat << EOF
#------------------------------------------------------------#

EOF
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
#---------------------------------------------#
#  <===========MAIN CODE STARTS============>  #
#---------------------------------------------#
get_install_dir
get_master_key
#Print help without masterkey
case "$@" in
   -h|--help)bash $ipath/src/help_page.sh;exit;;
esac
#---------------------------------------------#
#Ask user to enter masterkey
echo "Enter Master Key: "
read -s user_entered_key
  if [[ "$user_entered_key" == "$master_key" ]];then
     echo "Access Granted." 
#-----#
#echo "No of Arguments:$#"
if [ $# -eq 0 ] ;then
#echo " Arguments $#"
print_welcome
bash $ipath/src/list.sh
print_close
read -p "Enter nickname: " nickname
   case "$nickname" in
     q|exit|quit)exit;;
   esac
#echo "You have selected $nickname"
bash $ipath/src/show_details.sh $nickname
print_close
else
case "$@" in
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
--reset-masterkey|-rmk)
print_welcome
bash $ipath/src/reset_masterkey.sh
print_close
;;
--version|-v)
echo "Keys version 1.0.0";;
*)echo "Not a valid argument."

esac
fi

# masterkey condirion
else
   echo "Entered wrong password." 
   exit
fi
