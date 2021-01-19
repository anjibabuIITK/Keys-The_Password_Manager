#!/bin/bash
#file=".Password_Manager/etc/Database/database"
file="text.dat"
name=`grep " $1:" $file |cut -d ":" -f1`
password=`grep " $1:" $file |cut -d ":" -f2`
hint=`grep " $1:" $file |cut -d ":" -f3`
lst_update=`grep " $1:" $file |cut -d ":" -f4`

echo "#-------------------------------------------------------#"
echo "#               Welcome to Keys			      #"	
echo "#-------------------------------------------------------#"
echo " Details:"
echo ""
echo " nickname  :" $1
echo " User Name :" $name
echo " Password  :" $password
echo " hint	 :" $hint
echo " Last updated on :" $others
echo ""
echo "#-------------------------------------------------------#"




