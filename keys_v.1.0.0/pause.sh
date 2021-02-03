#!/bin/bash
function pause(){
local msg="$@"
[ -z $msg ] && msg="$bold $red Press [Enter] key to continue... $reset"
read -p "$msg" readEnterKey
}
pause
