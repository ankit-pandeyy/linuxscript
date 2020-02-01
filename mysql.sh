###### MYSQL #######
#!/bin/bash
# RHEL / CentOS / Fedora Linux restart command
RESTART="/etc/init.d/mysql.server start"
d=$(date)
# uncomment if you are using Debian / Ubuntu Linux
#RESTART="/etc/init.d/mysql restart"

#path to pgrep command
PGREP="/usr/bin/pgrep"

# Httpd daemon name,
# Under RHEL/CentOS/Fedora it is httpd
# Under Debian 4.x it is apache2
MYSQL="mysql"
# find httpd pid
$PGREP ${MYSQL}
if [ $? -ne 0 ] # if Mysql not running
then
 # restart Mysql
echo Mysql was down and started by a script on $d  | nail -s "Mysql was down"  himanshu.pandey@payu.in
 $RESTART
fi
