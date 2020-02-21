#!/bin/bash
# Sample script to demonstrate the creation of an HTML report using shell scripting
# Web directory
WEB_DIR=/var/www/html/Nocdashboard
# A little CSS and table layout to make the report look a little nicer
echo "<HTML>
<HEAD>
<style>
.titulo{font-size: 1em; color: white; background:#0863CE; padding: 0.8em 0.8em;}
table
{
 width: 100%;
border-collapse:collapse;
}
table, td,th
{
font-size:40px;
border:3px solid black;
}
</style>
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8' />
</HEAD>
<BODY>" > $WEB_DIR/report.html
# View hostname and insert it at the top of the html body
HOST=$(hostname)
echo "Filesystem usage for host <strong>$HOST (10.50.12.165)</strong><br>
Last updated: <strong>$(date)</strong><br><br>
<table border='1'>
<tr><th class='titulo'>FILESYSTEM</td>
<th class='titulo'>SIZE</td>
<th class='titulo'>USED</td>
<th class='titulo'>AVAILABLE</td>
<th class='titulo'>USE %</td>
<th class='titulo'>MOUNTED</td>
</tr>" >> $WEB_DIR/report.html
# Read the output of df -h line by line
df -h | while read line; do
echo "<tr><td align='center'>" >> $WEB_DIR/report.html
echo $line | awk '{print $1}' >> $WEB_DIR/report.html
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
echo "</td></tr>" >> $WEB_DIR/report.html
done
echo "</table></BODY></HTML>" >> $WEB_DIR/report.html
