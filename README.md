##                  Keys  [The_Password_Manager]
    
    
    
    
    Description:
"Keys" is a password manager to help a user to store and organize passwords. Keys manages and stores
 the passwords encrypted and locally, requiring the user to create a master password: a single, ideally
 very strong password which grants the user access to their entire password database. Keys protects the 
 user data using the AES-256-cbc encryption with salted.


USAGE: keys <command> [-ne],[-ue],[-h],[-re],[--set_profile],[--set_masterkey]

Features :

keys or keys list
   This command prints the available nicknames to select.

keys --help|-h
   This command prints the information about package.

keys --new_entry|-ne
   This command collects the details from the user from terminal. nickname is mandatory to be unique.
   However, it will warns the user if nickname already exists.

keys --remove-entry|-re
   This command removes the entry for given nickname.

keys --update-entry|-ue
   This command updates the existed nickname. And warns if nickname doesn't existed.
   And suggests to use --new_entry command.
keys --set_profile
   This command sets the user datails and sets master key.

keys --set_masterkey
   This command resets the master key. User needs to be authenticate by typing OTP sent ti regustred mail.


---
Master mind:
Anji Babu Kapakayala
IIT Kanpur, India.

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    **"Keys " is the tool to manage your passwords locally in your PC/laptop.**
      
      writes users data in .psswd_manger/tmp/info.txt encrypted format AES-256-cbc

**File format:**

      <nickname>:  <username/userid>  <Password>  <hits>  <last-updated>

**exampe:**

      anji: <anjibabu480> <newoneher> <"its my dummy password"> <"18.01.2021:19:59">

**Features :**

      keys or keys list
      This command should list the available nicknames

      keys --help|-h
      This command should print all the information about package

      keys --new_entry|-ne
      This command should promt to collect details from the user. and warns if
      nickname already exists.

      keys --remove-entry|-re
      This command will remove the entry for given nickname.

      keys --update-entry|-ue
      This command will modify the existed nickname. And warns if nickname doesn't existed.
      And will suggest to use --new_entry command.

      keys --set_profile
      This command stores the user datails and sets master key

      keys --set_masterkey
      This command sets or resets the master key when needed. user have to enter OTP sent
      to registred mail id. User can't reset master if mail id is not registred.

**Later updates: (Enable Security)**

    1. Package should have one master password to access. or should able to send an OTP
    to mobile and mail to access the passwords. We need to configure with mutt package
    and wayto sms.

    2. Need to encrypt the user data, so that no one can able to open and see it.


**Encription:**
      
      Uses the openssl aes-256-cbc encryption and dycription.
      
      Ref:
    1. https://askubuntu.com/questions/60712/how-do-i-quickly-encrypt-a-file-with-aes
    2. man enc


**STATUS of the Prjoect:**
          
      Work is under progress


  
    Master mind:
    Anji Babu Kapakayala
    IIT Kanpur, India.

