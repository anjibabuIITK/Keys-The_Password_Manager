#!/bin/bash 
# This script is a part of password manager tool (Keys)
nickname="$1"
echo "Given nickname is: $nickname"
#file=".Password_Manager/etc/Database/tmp.info"
file=file.txt
sed -i "/$nickname:/d" $file
