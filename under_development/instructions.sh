#!/bin/bash
#------------------------------------------------------------------------#
function prompt_instructions() {
cat <<EOF

Gmail Setup :

    IMAP setup :

  In your gmail, click the gear icon on right corner, open Settings.
  Then click on Forwarding POP/IMAP on top , and enable IMAP Aceess.
  Click on configuration instructions to know more about IMAP access settings.

    SSL setup:

  Inorder to access your gmail,you need to provide the access rights to use smtp server.
  turn ON the access to the less secure app from the Google account.

  paste the following in google and login to your goole account and turn on the 
  access to the less secure app.

  link:
  https://myaccount.google.com/lesssecureapps?rapt=AEjHL4O_kqNYY2u6Bx_T_9R2Yja9tkjiVA-ScsE2OvzT4lakWYRwZfSkLcBYKJ98DYfrLuEx_5VOKFrFyBJ4URzX5hfISIMLxA
EOF
sleep 5
xdg-open https://myaccount.google.com/lesssecureapps?rapt=AEjHL4O_kqNYY2u6Bx_T_9R2Yja9tkjiVA-ScsE2OvzT4lakWYRwZfSkLcBYKJ98DYfrLuEx_5VOKFrFyBJ4URzX5hfISIMLxA

}
#------------------------------------------------------------------------#
prompt_instructions


