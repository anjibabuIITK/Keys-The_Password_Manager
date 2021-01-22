#---------------------------------------------#
#    <=============KEYS=============>
#---------------------------------------------#
# This code is a part of Keys tool
#---------------------------------------------#
#!/bin/bash
#---------------------------------------------#
path=$HOME/.keys/etc/profile
profile=$HOME/.keys/etc/profile/profile
recovery=$HOME/.keys/etc/profile/recovery
database=$HOME/.keys/etc/Database/database
master_file=$HOME/.keys/etc/profile/masterkey
install_file=$HOME/.keys/etc/path/install_path
ipath=`cat $install_file |awk '{print $1}'`
[ -d $path ] ||mkdir -p $path
#---------------------------------------------#
# When ever access this code ask for masterkey.
function get_master_key() {
#decrypting the masterkey
bash $ipath/src/encrypt.sh -de $master_file
master_key=`cat $master_file |awk '{print $1}'`
#enecrypting the masterkey
bash $ipath/src/encrypt.sh -en $master_file
#echo "$master_key"
}
#---------------------------------------------#
function Get_recovery_questions() {
#decrypting the masterkey
bash $ipath/src/encrypt.sh -de $recovery
r_key=`cat $recovery|cut -d ":" -f1`
Q1=`cat $recovery|cut -d ":" -f2`
QA1=`cat $recovery|cut -d ":" -f3`
Q2=`cat $recovery|cut -d ":" -f4`
QA2=`cat $recovery|cut -d ":" -f5`

#enecrypting the masterkey
bash $ipath/src/encrypt.sh -en $recovery
}
#---------------------------------------------#
#    <==========Main code=========>
#---------------------------------------------#
get_master_key
Get_recovery_questions

#---> If recover questions already exists, continue
if [[ "$r_key" == "1" ]];then
echo ;echo "  Answer the bellow questions to recover the current Master Key: "

read -p "$Q1 : " ans1
if [[ "$ans1" == "$QA1" ]];then
   echo "   Correct Answer." 
   read -p "$Q2 : " ans2
   if [[ "$ans2" == "$QA2" ]];then
      echo "   Correct Answer."
      echo "The current master key is: $master_key "
   else
      echo "   Wrong Answer.";exit
   fi
else
   echo "   Wrong Answer." ;exit
fi
#---> If recover questions not exists, Inform and exit
else
echo ;echo " Recovery questions not been set yet."
echo "Complete user registration using bellow command"
echo "keys --set-profile"
exit
fi
#---------------------------------------------#
#    <==========ANJI BABU KAPAKAYALA========>
#---------------------------------------------#
