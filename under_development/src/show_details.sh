#---------------------------------------------#
#  <=============KEYS===============>
#---------------------------------------------#
#!/bin/bash
path=$HOME/.keys/etc/profile
profile=$HOME/.keys/etc/profile/profile
database=$HOME/.keys/etc/Database/database
master_file=$HOME/.keys/etc/profile/masterkey
install_file=$HOME/.keys/etc/path/install_path
ipath=`cat $install_file |awk '{print $1}'`
[ -d $path ] ||mkdir -p $path
#---------------------------------------------#
#decrypt database
bash $ipath/src/encrypt.sh -de $database
a=`grep " $1:" $database`
if [ $? -eq 0 ]
then
name=`grep " $1:" $database |cut -d ":" -f2`
password=`grep " $1:" $database |cut -d ":" -f3`
hint=`grep " $1:" $database |cut -d ":" -f4`
lst_update=`grep " $1:" $database |cut -d ":" -f5`
#decrypt database
bash $ipath/src/encrypt.sh -en $database

echo " Details:"
echo ""
echo " nickname  :" $1
echo " User Name :" $name
echo " Password  :" $password
echo " hint	 :" $hint
echo " Last updated on :" $lst_update
echo ""
else
echo "";echo " Not a valid nickname."
exit
fi
#---------------------------------------------#
#  <========ANJI BABU KAPAKAYALA======>
#---------------------------------------------#
