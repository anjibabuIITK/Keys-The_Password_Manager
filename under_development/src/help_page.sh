#---------------------------------------------#
# This code is a part of Keys tool
#---------------------------------------------#
#!/bin/bash
#cho "#--------------------------------------------------------------------------------------#"
#toilet --gay "Keys" 

#cho "A tool to manasge your passwords at one place.  		"	
#cho "#--------------------------------------------------------------------------------------#"
cat << EOF
      <----------------------------------------------------------------------------->
                                      KEYS
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

	keys or keys list
	   This command prints the available nicknames to select.

	keys --help|-h
	   This command prints the information about package.

	keys --new-entry|-ne
	   This command collects the details from the user from terminal. nickname is 
           mandatory to be unique. However, it will warns the user if nickname already
           exists.

	keys --remove-entry|--delete-entry|-re
	   This command removes the entry for given nickname.

	keys --update-entry|-ue
	   This command updates the existed nickname. And warns if nickname doesn't
           existed.And suggests to use --new_entry command.

	keys --set-profile|-sp
	   This command sets the user datails, master key and recovery questions.

	keys --reset-masterkey|-rmk
	   This command resets the master key. User needs to be authenticate by typing OTP sent ti regustred mail.
	
	keys --recover-masterkey|-recover
	   This command recovers the master key if, user answers correctly for registred recovery questions.

	Keys --version|-v
	   Prints the current version of the code.
	
	Keys --enable-OTP
	  Enables the OTP service.

	Keys --disable-OTP
	  Disables the OTP service.

	Keys --update-profile
	  Updates the user profile details including recovery options.
---
Master mind:
Anji Babu Kapakayala
IIT Kanpur, India.

EOF
