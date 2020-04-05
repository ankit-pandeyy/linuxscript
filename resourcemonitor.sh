#!/bin/bash
# Sample script to demonstrate the creation of an HTML report using shell scripting
# Web directory
WEB_DIR=/var/www/html/
# A little CSS and table layout to make the report look a little nicer
echo "<HTML>
<HEAD>
<style>
.titulo{font-size: .8em; color: white; background:#0863CE; padding: 0.8em 0.8em;}
table
{
 width: 100%;
border-collapse:collapse;
}
table, td,th
{
font-size:30px;
border:2px solid black;
}
</style>
<meta http-equiv="refresh" content="30">
<title>Server Disk Status</title><link rel="icon" href="https://cdn4.iconfinder.com/data/icons/circle-payment/32/payment_004-payu-money-512.png" type="image/icon type"sizes="40x30">
</HEAD>
<BODY>" > $WEB_DIR/report.html
# View hostname and insert it at the top of the html body
HOST=$(hostname)
ip=$(/sbin/ifconfig | awk '/inet 10/ {print $2}')
c=$(top -bn1 | grep id | awk '{print expr 100 - $8 }')
r=$(free -h | awk 'NR==2{printf "%s/%s (%.2f%%)\n", $3,$2,$3*100/$2 }')
echo  "Filesystem usage for host <strong>($HOST) ($ip)</strong><br>
Last updated: <strong>$(date)</strong><br><br>
<table border='1'>
<tr><th class='titulo'>I.P</td>
<th class='titulo'>SIZE</td>
<th class='titulo'>USED</td>
<th class='titulo'>AVAILABLE</td>
<th class='titulo'>USE %</td>
<th class='titulo'>MOUNTED</td>
<th class='titulo'>CPU UTILIS.</td>
<th class='titulo'>RAM UTILIS.</td>
</tr> </h>" >> $WEB_DIR/report.html
# Read the output of df -h line by line  df -h | awk '0+$5 >= 50'
 df -h | awk '0+$5 >= 50' | while read line; do
echo "<tr><td align='center'>" >> $WEB_DIR/report.html
echo $ip >> $WEB_DIR/report.html
echo "</td><td align='center'>" >> $WEB_DIR/report.html
echo $line | awk '{print $2}' >> $WEB_DIR/report.html
echo "</td><td align='center'>" >> $WEB_DIR/report.html
echo $line | awk '{print $3}' >> $WEB_DIR/report.html
echo "</td><td align='center'>" >> $WEB_DIR/report.html
echo $line | awk '{print $4}' >> $WEB_DIR/report.html
echo "</td><td align='center'>" >> $WEB_DIR/report.html
echo $line | awk '{print $5}' >> $WEB_DIR/report.html
echo "</td><td align='center'>" >> $WEB_DIR/report.html
echo $line | awk '{print $6}' >> $WEB_DIR/report.html
echo "</td><td align='center'>" >> $WEB_DIR/report.html
echo $c% >> $WEB_DIR/report.html
echo "</td><td align='center'>" >> $WEB_DIR/report.html
echo $r >> $WEB_DIR/report.html
echo "</td></tr>" >> $WEB_DIR/report.html
done
echo "</table></BODY></HTML>" >> $WEB_DIR/report.html
