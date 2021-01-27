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
bash $ipath/src/encrypt.sh -dd $database
a=`grep " $1:" $database`
if [ "$?" == "0" ];then
# Encrypt the database after using
bash $ipath/src/encrypt.sh -ed $database
show_menu $1
else
echo "$bold$red Keys$rst:$bold Invalid nickname ($red $1 $rst).$rst"
# Encrypt the database after using
bash $ipath/src/encrypt.sh -ed $database
fi
}
#-------------------------------------------------#
function show_menu() {
#decrypt database
bash $ipath/src/encrypt.sh -dd $database
a=`grep " $1:" $database`
if [ $? -eq 0 ]
then
name=`grep " $1:" $database |cut -d ":" -f2`
password=`grep " $1:" $database |cut -d ":" -f3`
hint=`grep " $1:" $database |cut -d ":" -f4`
lst_update=`grep " $1:" $database |cut -d ":" -f5`
#decrypt database
bash $ipath/src/encrypt.sh -ed $database

echo
echo "$bold$ylw Details of ($grn $1 $rst):$rst"
echo ""
#echo " nickname  :" $1
echo "$bold$grn     User Name :$rst" $name
echo "$bold$grn     Password  :$rst" $password
echo "$bold$grn     Hint      :$rst" $hint
echo "$bold$grn     Updated on:$rst" $lst_update
echo ""
else
echo "";echo "$bold$red Keys:$rst $bold Not a valid nickname.$rst"
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
