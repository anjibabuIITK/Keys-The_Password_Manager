#--------------------------------------------------#
#    This code is a part of Keys tool  		   #
#  						   # 
#  Usage: 					   #
#   To encrypt:  bash encrypt.sh -en filename      #
#   To decrypt:  bash encrypt.sh -de filename      #
#  						   # 
#--------------------------------------------------#
install_dir=${KEYS_INSTALL_DIR}
cache=${install_dir}/.keys/cache/random
#--------------------------------------------------#
function encrypt_old() {
passwd=$RANDOM
# Encrypt file with password $passwd
openssl enc -aes-256-cbc -salt -k $passwd -in $1 -out $1.key
rm $1
#---> Store password
cat > $cache <<EOF
$passwd
EOF
}
#--------------------------------------------------#
function encrypt() {
passwd=$RANDOM
# Encrypt file with password $passwd
openssl enc -aes-256-cbc -salt -k $passwd -in $1 -out $1.key
rm $1
#---> Store password
case "$2" in
-p)p=$passwd
   store="${p}:${m}:${d}:${re}";;
-m)m=$passwd
   store="${p}:${m}:${d}:${re}";;
-d)d=$passwd
   store="${p}:${m}:${d}:${re}";;
-r)re=$passwd
   store="${p}:${m}:${d}:${re}";;
esac
cat > $cache <<EOF
$store
EOF
}
#--------------------------------------------------#
function decrypt() {
#---> fetch the password
case "$2" in
-p)passwd=$p;;
-m)passwd=$m;;
-d)passwd=$d;;
-r)passwd=$re;;
esac
# Decrypt file with password $passwd 
openssl enc -d -aes-256-cbc -salt -k $passwd -in $1.key -out $1
rm $1.key
}
#--------------------------------------------------#
function decrypt_old() {
passwd=`awk '{print $1}' $cache`
echo $passwd 
# Decrypt file with password $passwd 
openssl enc -d -aes-256-cbc -salt -k $passwd -in $1.key -out $1
rm $1.key
}
#--------------------------------------------------#
function Get_memeory() {
#order p-m-d-re
p=`awk '{print $1}' $cache|cut -d ':' -f1`
m=`awk '{print $1}' $cache |cut -d ':' -f2`
d=`awk '{print $1}' $cache |cut -d ':' -f3`
re=`awk '{print $1}' $cache |cut -d ':' -f4`
}
#--------------------------------------------------#
#     <=========== MAIN CODE ==========>
#--------------------------------------------------#
Get_memeory
#---->
case "$1" in

   encrypt|-en) encrypt_old $2;;
   encrypt-p|-ep) encrypt $2 -p;;
   encrypt-m|-em) encrypt $2 -m;;
   encrypt-d|-ed) encrypt $2 -d;;
   encrypt-r|-er) encrypt $2 -r;;
   decrypt|-de) decrypt_old $2;;
   decrypt-p|-dp) decrypt $2 -p;;
   decrypt-m|-dm) decrypt $2 -m;;
   decrypt-d|-dd) decrypt $2 -d;;
   decrypt-r|-dr) decrypt $2 -r;;
   *)echo "Keys: Cryptographic error.";;
esac
#<----
#--------------------------------------------------#
#       Written by Anji Babu Kapakayala		   #
#            IIT Kanpur, India.			   #
#--------------------------------------------------#
