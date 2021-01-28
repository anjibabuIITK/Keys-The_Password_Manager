#--------------------------------------------------------------#
# This code is a part of Keys tool	     		       #
# Written by Anji Babu Kapakayala	                       #
#--------------------------------------------------------------#
# Defining text colors
red=`tput setaf 1`
grn=`tput setaf 2`
ylw=`tput setaf 3`
blu=`tput setaf 4`
pur=`tput setaf 5`
rst=`tput sgr0`
bold=`tput bold`
#---------------------------------------------------------------#
#!/bin/bash
cat << EOF
      <----------------------------------------------------------------------------->
                    $bold$blu<===========$rst $bold$ylw WELCOME TO KEYS$rst$bold$blu ==========>$rst
	           A tool to manasge your passwords at one place.  			
      <------------------------------------------------------------------------------>
 
     Install:
         Install the Keys package using installer provided.
         ./install

     Description:

	"Keys" is a password manager to help a user to store and organize passwords.
         Keys manages and stores the passwords encrypted and locally, requiring the 
         user to create a master password: a single, strong password  which  grants 
         the user access to their entire password database. Keys protects the user's
         data using the AES-256-cbc encryption with salted format.

     USAGE: 
         keys <argument> [-ne],[-ue],[-h],[-re],[--set_profile],[--reset_masterkey]
                     
     Options :

	keys 
	   Shows the available nicknames and ask user to select nickname.
	
	keys list
	   Prints the available nicknames and exit.

	keys --nickname|-n
	   Prints the details of given nickname.

	keys --help|-h
	   Prints the information about package and exit.

	keys --new-entry|-ne
	   Collects the details from the user and stores in database. nickname is
	   mandatory to be unique. However, it will warns the user if nickname already
	   exists.

	keys --remove-entry|--delete-entry|-re|
	   Removes the entry for given nickname from the database.

	keys --update-entry|-ue
	   Updates the existed nickname. And warns if nickname doesn't existed. 
	   And suggests to use --new_entry command.

	keys --set-profile|-sp
	   Register user profile and datails such as master key and recovery questions.

	keys --reset-masterkey|-rmk
	   Resets the master key afer user authentication either OTP or previous masterkey.
	
	keys --recover-masterkey|-recover
	   Recovers the master key based on registred recovery questions.

	Keys --version|-v
	   Prints the current version of the code.
	
	Keys --enable-OTP
	  Enables the OTP service.

	Keys --disable-OTP
	  Disables the OTP service.

	Keys --update-profile
	  Updates the user profile details including recovery options.
	
	Keys --uninstall|--clean
	  Removes the all database and uninstalls the keys package.
 
	Keys --import|-imp 
          Imports the data from the file to database.
	
	Keys --export|-exp 
          Exports the data from database to given file.



     Examples:



     Authour:
         Anji Babu Kapakayala
        (anjibabu480@gmail.com)
          IIT Kanpur, India.

EOF
