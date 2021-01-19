#!/bin/bash

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
file=".Password_Manager/etc/Database/tmp.info"
#file="text.dat"
array=`awk {'print $1'} $file|cut -d ':' -f1`
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
paste tmp* > FILE
rm tmp*
# Welcome Msg
print_welcome
cat FILE
print_close
rm FILE

