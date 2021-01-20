# Configuration file to install password manager
#!/bin/bash
mkdir -p .Password_Manager/etc/Database
mkdir -p .Password_Manager/etc/profile
master_file=.Password_Manager/etc/profile/masterkey
initial_key=123456
cat >>.Password_Manager/etc/Database/database<<EOF
No DATA ENTERED
EOF
cat > $master_file <<EOF
$initial_key
EOF
#install mutt
# Check for mutt package, if installed check for .muttrc
# if not installed install mutt and configure it using defaults mailid details: keys@gmail.com



# check for bash
# install & update in .bashrc

#[ -f  "$file"  ] && echo "File extst" || echo "No file found"
