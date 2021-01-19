#!/bin/bash
function print_welcome() {
cat << EOF
#------------------------------------------------------------#
#               Welcome to Password Manager		     #    
#                    Entry Details		             #
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
last_updated=`date`
print_welcome
read -p "Give  nickname:", nickname
read -p "User ID/username: ", username
read -p "Password: ", password
read -p "Any hints :", hints
#update last_update = $time
echo "update last_update = $last_updated"


# write to $file in a specified format


print_close
