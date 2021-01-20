#---------------------------------------------#
# This code is a part of Keys tool
#---------------------------------------------#
#!/bin/bash
#Check .Password_Manager/etc/profile exists or not. if not create
path=.Password_Manager/etc/profile
file=.Password_Manager/etc/profile/profile
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
function set_profile() {
echo;echo " User Registration: "
read -p "Name : " usr_name
read -p "Email: " usr_mail
read -p "Phone Number:" phone_nmbr

#decrypt the file
cat > $file <<EOF
 $usr_name:$usr_mail:$phone_nmbr
EOF
#encrypt 


read -p " Wanna reset Master Key [yes/no]: " option
echo "$option"
if [[ "$option" == "yes" ]];then
echo " Resetting Master Key: "
read -p "Enter Master key:" master_key
#decrypt the file
cat > $master_file <<EOF
$master_key
EOF
#encrypt 
else
echo " Master Key has not changed."
fi


#bash src/encrypt.sh -en $path/profile
}
#---------------------------------------------#
#  main
#---------------------------------------------#
#[ -f  "$file"  ] && bash src/encrypt.sh -en $file
#if $file is not empty, print user profile already existed, use reset profile 
# Access this code by asking master key, use default master key as 123456
# use reset_master key command to update masterkey. there ask previous masterkey to update.
get_master_key
#Ask user to enter masterkey
echo "Enter Master Key: "
read -s user_entered_key

#[ $user_entered_key -eq $master_key ] && echo "Password matched." || echo "Entered wrong password." 
if [[ "$user_entered_key" == "$master_key" ]];then
   echo "Access Granted." 

# Ask user to set profile
set_profile
echo;echo " User has been registered successfully. "

else
   echo "Entered wrong password." 
   exit
fi
