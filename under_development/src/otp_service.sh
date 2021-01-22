#---------------------------------------------------------------#
#     <====================== KEYS ====================>
#---------------------------------------------------------------#
# "Keys" is a tool for managing your Passwords at one place.
#
# Authour: Anji Babu Kapakayala
#          IIT Kanpur, India.
#          anjibabu480@gmail.com
#
#!/bin/bash
#---------------------------------------------------------------#
# Defining text colors
red=`tput setaf 1`
grn=`tput setaf 2`
ylw=`tput setaf 3`
blu=`tput setaf 4`
pur=`tput setaf 5`
rst=`tput sgr0`
bold=`tput bold`
#---------------------------------------------------------------#
#Check .Password_Manager/etc/profile exists or not. if not create
path=$HOME/.keys/etc/profile
profile=$HOME/.keys/etc/profile/profile
recovery=$HOME/.keys/etc/profile/recovery
database=$HOME/.keys/etc/Database/database
master_file=$HOME/.keys/etc/profile/masterkey
install_file=$HOME/.keys/etc/path/install_path
[ -d $path ] ||mkdir -p $path
#---------------------------------------------#
