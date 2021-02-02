#!/bin/bash
file1=$2

cat >$file1<<EOF
# Welcome to Keys secure Note
# Write Here and press esc then type :wq! to save details
EOF
vi $file1
#encrypt
passwd="secret"
openssl enc -aes-256-cbc -salt -k $passwd -in $file1 -out $file1.key
rm $file1
