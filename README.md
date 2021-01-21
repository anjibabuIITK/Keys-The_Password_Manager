### <======================= Keys ========================>

The Password Manager written in shell/bash.
 
**Authour:**
    
    Anji Babu Kapakayala
    IIT Kanpur, India.
    anjibabu480@gmail.com

    
 **Description:**
            
    "Keys" is a password manager to help a user to store and organize passwords. Keys manages and 
    stores the passwords encrypted and locally, requiring the user to create a master password: 
    a single, ideally very strong password which grants the user access to their entire password 
    database. Keys protects the user data using the AES-256-cbc encryption with salted.
    
**INSTALL:**

    bash installer.sh
    
**UN-INSTALL:**

    bash installer.sh clean

**USAGE:**

    keys <command> [-ne],[-ue],[-h],[-re],[--set-profile],[--set-masterkey],[-v]

**Features :**

    keys or keys list
    This command prints the available nicknames to select.

    keys --help|-h
    This command prints the information about package.

    keys --new-entry|-ne
    This command collects the details from the user from terminal. nickname is mandatory 
    to be unique. However, it will warns the user if nickname already exists.

    keys --remove-entry|-re
    This command removes the entry for given nickname.

    keys --update-entry|-ue
    This command updates the existed nickname. And warns if nickname doesn't existed.
    And suggests to use --new_entry command.

    keys --set-profile|-sp
    This command sets the user datails and sets master key.

    keys --reset-masterkey|-rmk
    This command resets the master key. User needs to be authenticate by typing OTP 
    sent to the regustred mail.
    
    keys -v|--version
    Prints the current version of the code.


    ---
    Master mind:
    Anji Babu Kapakayala
    IIT Kanpur, India.

## <======================= Keys ========================>
   
