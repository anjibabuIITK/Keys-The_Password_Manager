#---------------------------------------------#
# This code is a part of Keys tool
#---------------------------------------------#
#!/bin/bash
#Check .Password_Manager/etc/profile exists or not. if not create
path=.Password_Manager/etc/profile
file=.Password_Manager/etc/profile/profile
[ -d $path ] ||mkdir -p $path
#---------------------------------------------#
function set_profile() {
echo;echo " User Registration: "
read -p "Name : " usr_name
read -p "Email: " usr_mail
read -p "Phone Number:" phone_nmbr
read -p "Master key:" master_key

cat > $path/profile <<EOF
NAME = $usr_name
USER_EMAIL = $usr_mail
MOBILE = $phone_nmbr
MASTER_KEY = $master_key
EOF

bash src/encrypt.sh -en $path/profile
}
#---------------------------------------------#
#  main
#---------------------------------------------#
[ -f  "$file"  ] && bash src/encrypt.sh -en $file
set_profile
echo;echo " User has been registered successfully. "
