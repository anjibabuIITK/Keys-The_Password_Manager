#!/bin/bash
#---------------------------------------------#
path=$HOME/.keys/etc/profile
profile=$HOME/.keys/etc/profile/profile
database=$HOME/.keys/etc/Database/database
master_file=$HOME/.keys/etc/profile/masterkey
install_file=$HOME/.keys/etc/path/install_path
ipath=`cat $install_file |awk '{print $1}'`
[ -d $path ] ||mkdir -p $path
#---------------------------------------------#
function print_welcome() {
cat << EOF
#------------------------------------------------------------#
#               Welcome to Password Manager		     #    
#                 Available nick names		             #
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
# Main code
#-------------------------------------------------#
# Decrypt the database before using
bash $ipath/src/encrypt.sh -de $database
array=`awk {'print $1'} $database|cut -d ':' -f1`
j=0;k=0
for i in $array;do
echo "$i" >> tmp$k
j=`expr $j + 1`
if [ $j -eq 10 ] 
then
 k=`expr $k + 1`
j=0
fi
done
# Encrypt the database after using
bash $ipath/src/encrypt.sh -en $database
#
paste tmp* > FILE
rm tmp*
# Welcome Msg
#print_welcome
echo ""
echo "Available Nicknames:"
cat FILE
#print_close
rm FILE

