# This code is a part of Password manager tool
#
# Authour: Anji Babu Kapakayala
#          IIT Kanpur, India.
#
#
#!/bin/bash
case "$@" in

-ne|--new_entry)echo "New entry";;
-ue|--update_entry)echo "Update Entry";;
-h|--help) echo "Asking Help";;
-l|list|--list)echo "List available nicknames";;
-re|--remove_entry|--delete_entry)echo "Delete the entry";;
*)echo "Its defaults case";;
esac


