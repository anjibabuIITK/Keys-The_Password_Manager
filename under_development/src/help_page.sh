#---------------------------------------------#
# This code is a part of Keys tool
#---------------------------------------------#
#!/bin/bash
cat << EOF
      <----------------------------------------------------------------------------->
                      <=========== WELCOME TO KEYS ==========>
	           A tool to manasge your passwords at one place.  			
      <------------------------------------------------------------------------------>
 
     Install:
         Install the Keys package using installer.sh provided.
         bash installer.sh

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
---
Master mind:
Anji Babu Kapakayala
IIT Kanpur, India.

EOF
