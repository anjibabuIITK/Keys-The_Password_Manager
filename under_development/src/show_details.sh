#---------------------------------------------#
#  <=============KEYS===============>
#---------------------------------------------#
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
#!/bin/bash
#path=$HOME/.keys/etc/profile
#profile=$HOME/.keys/etc/profile/profile
#database=$HOME/.keys/etc/Database/database
#master_file=$HOME/.keys/etc/profile/masterkey
#install_file=$HOME/.keys/etc/path/install_path
#ipath=`cat $install_file |awk '{print $1}'`
#[ -d $path ] ||mkdir -p $path
#---------------------------------------------#
#-------------------------------------------------#
# function to check nickname
function If_valid_show() {
# Decrypt the database before using
bash $ipath/src/encrypt.sh -de $database
a=`grep " $1:" $database`
if [ "$?" == "0" ];then
# Encrypt the database after using
bash $ipath/src/encrypt.sh -en $database
show_menu $1
else
echo " Keys: Invalid nickname ($1)."
# Encrypt the database after using
bash $ipath/src/encrypt.sh -en $database
fi
}
#-------------------------------------------------#
function show_menu() {
#decrypt database
bash $ipath/src/encrypt.sh -de $database
a=`grep " $1:" $database`
if [ $? -eq 0 ]
then
name=`grep " $1:" $database |cut -d ":" -f2`
password=`grep " $1:" $database |cut -d ":" -f3`
hint=`grep " $1:" $database |cut -d ":" -f4`
lst_update=`grep " $1:" $database |cut -d ":" -f5`
#decrypt database
bash $ipath/src/encrypt.sh -en $database

echo " Details:"
echo ""
echo " nickname  :" $1
echo " User Name :" $name
echo " Password  :" $password
echo " hint	 :" $hint
echo " Last updated on :" $lst_update
echo ""
else
echo "";echo " Not a valid nickname."
exit
fi
}
#-------------------------------------------------#
#   <================MAIN CODE==============>
#-------------------------------------------------#
# if user enter empty entry
#--->
if [ $# -eq 0 ] ;then
exit
else
# Have to check is nickname is valid or not?
If_valid_show $1

fi
#---------------------------------------------#
#  <========ANJI BABU KAPAKAYALA======>
#---------------------------------------------#
