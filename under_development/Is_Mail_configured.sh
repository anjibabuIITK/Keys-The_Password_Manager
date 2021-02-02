#!/bin/bash
a=`echo "TEST"|mutt -s "TEST" anjibabu480@gmail.com`
if [ $? -eq 0 ];then
echo "Mailing service has configured."
else
echo "Mailing service has NOT configured. kindly use --enable-Mails tag"
fi

