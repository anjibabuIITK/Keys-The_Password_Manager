#---------------------------------------------#
#    <=============KEYS=============>
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
#enecrypting the masterkey
bash $ipath/src/encrypt.sh -em $master_file
#echo "$master_key"
}
#---------------------------------------------#
function Get_recovery_questions() {
#decrypting the masterkey
bash $ipath/src/encrypt.sh -dr $recovery
r_key=`cat $recovery|cut -d ":" -f1`
Q1=`cat $recovery|cut -d ":" -f2`
QA1=`cat $recovery|cut -d ":" -f3`
Q2=`cat $recovery|cut -d ":" -f4`
QA2=`cat $recovery|cut -d ":" -f5`

#enecrypting the masterkey
bash $ipath/src/encrypt.sh -er $recovery
}
#---------------------------------------------#
#    <==========Main code=========>
#---------------------------------------------#
get_master_key
Get_recovery_questions

#---> If recover questions already exists, continue
if [[ "$r_key" == "1" ]];then
echo ;echo "$bold$ylw  Answer the bellow questions to recover the current Master Key: $rst"
echo;read -p "$bold$pur        $Q1 : $rst" ans1
if [[ "$ans1" == "$QA1" ]];then
   echo "$bold$red Keys:$rst$bold$grn Correct Answer.$rst" 
   echo;read -p "$bold$pur        $Q2 : $rst" ans2
   if [[ "$ans2" == "$QA2" ]];then
   echo "$bold$red Keys:$rst$bold$grn Correct Answer.$rst" 
   echo;echo "$bold$red Keys:$rst The current master key is:$rst$bold$red $master_key $rst"
   else
      echo "$bold$red Keys:$rst$bold   Wrong Answer.$rst";exit
   fi
else
      echo "$bold$red Keys:$rst$bold   Wrong Answer.$rst";exit
fi
#---> If recover questions not exists, Inform and exit
else
echo ;echo "$bold$red Keys:$rst Recovery questions could not found.$rst"
echo "$bold$red Keys:$rst Complete user registration using bellow command$rst"
echo "$bold$red keys$rst$bold$grn --set-profile$rst"
exit
fi
#---------------------------------------------#
#    <==========ANJI BABU KAPAKAYALA========>
#---------------------------------------------#
