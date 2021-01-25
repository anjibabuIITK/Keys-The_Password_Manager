#--------------------------------------------------#
#    This code is a part of Keys tool  		   #
#  						   # 
#  Usage: 					   #
#   To encrypt:  bash encrypt.sh -en filename      #
#   To decrypt:  bash encrypt.sh -de filename      #
#  						   # 
#--------------------------------------------------#
function encrypt() {
# Encrypt file with password secret
openssl enc -aes-256-cbc -salt -k secret -in $1 -out $1.key
rm $1
#chmod -R 777 $1.key
}
#--------------------------------------------------#
function decrypt() {
# Decrypt file with password secret
openssl enc -d -aes-256-cbc -salt -k secret -in $1.key -out $1
rm $1.key
#chmod -R 777 $1
}
#--------------------------------------------------#
case "$1" in

   encrypt|-en) encrypt $2;;
   decrypt|-de) decrypt $2;;

esac
#--------------------------------------------------#
#       Written by Anji Babu Kapakayala		   #
#            IIT Kanpur, India.			   #
#--------------------------------------------------#
