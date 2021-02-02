
#----------------------------------------#
# crontab -e :to edit from vi
# crontab -l :lists existed crontab jobs
#----------------------------------------#
# Installing crontab from script
#!/bin/bash
#write out current crontab
crontab -l > mycron
#echo new cron into cron file
echo "0 0 * * * keys --backup" >> mycron
#install new cron file
crontab mycron
rm mycron
#----------------------------------------#
