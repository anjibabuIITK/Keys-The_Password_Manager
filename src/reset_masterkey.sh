#---------------------------------------------#
# This code is a part of Keys tool
#---------------------------------------------#
#!/bin/bash
path=.Password_Manager/etc/profile
master_file=.Password_Manager/etc/profile/masterkey
[ -d $path ] ||mkdir -p $path
#---------------------------------------------#
# When ever access this code ask for masterkey.
function get_master_key() {
#decrypt the file
master_key=`cat $master_file |awk '{print $1}'`
#enecrypt the file
#echo "$master_key"
}
#---------------------------------------------#
function reset_master_key() {
read -p "  Are you sure to reset Master Key [yes/no]: " option
#echo "$option"
if [[ "$option" == "yes" ]];then
echo "   Resetting Master Key: "
echo "   Enter New Master key: "
read -s  master_key
#decrypt the file
cat > $master_file <<EOF
$master_key
EOF
#encrypt 
else
echo "   Master Key has not updated."
fi

#bash src/encrypt.sh -en $path/profile
}
#---------------------------------------------#
#   Main code
#---------------------------------------------#
get_master_key
#Ask user to enter masterkey
echo ;echo "  Enter Present Master Key: "
read -s user_entered_key

#[ $user_entered_key -eq $master_key ] && echo "Password matched." || echo "Entered wrong password." 
if [[ "$user_entered_key" == "$master_key" ]];then
   echo "   Access Granted." 
   reset_master_key
echo "   Master Key has been updated successfully."
else
   echo "   Entered wrong password." 
   exit
fi
