#----------------------------------------#
# Installing crontab from script
#Remove the crontab
function Remove_Autobackup() {
crontab -l > mycron
#echo new cron into cron file
a=`grep "keys --backup" mycron`
if [ "$?" == "0" ];then
sed -i "/keys --backup/d" mycron
#install new cron file
crontab mycron
rm mycron
fi
}
#---------------------------------------------#
Remove_Autobackup
