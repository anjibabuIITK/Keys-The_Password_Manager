# "Keys" is a tool for managing your Passwords at one place.
#
# Authour: Anji Babu Kapakayala
#          IIT Kanpur, India.
#
#
#!/bin/bash

function print_welcome() {
cat << EOF
#------------------------------------------------------------#
#                    Welcome to Keys    		     # 
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
#echo "No of Arguments:$#"
if [ $# -eq 0 ] ;then
#echo " Arguments $#"
print_welcome
bash src/list.sh
print_close
read -p "Enter nickname: " nickname

#echo "You have selected $nickname"
bash src/show_details.sh $nickname
print_close
else
case "$@" in
-ne|--new_entry)echo "New entry"
bash src/new_entry.sh;;
-ue|--update_entry)echo "Update Entry"
bash src/update_entry.sh ;;
-h|--help) echo "Asking Help"
bash src/help_page.sh;;
-l|list|--list)
print_welcome
bash src/list.sh
print_close
;;
-re|--remove_entry|--delete_entry)echo "Delete the entry";;
--set-profile|-sp)
print_welcome
bash src/set_user_profile.sh
print_close
;;
--reset-masterkey|-rmk)
print_welcome
bash src/reset_masterkey.sh
print_close
;;
*)echo "Not a valid argument."

esac
fi

