#!/bin/bash

hostnamectl --static set-hostname Seoul-AWS-WebSrv1
amazon-linux-extras install -y lamp-mariadb10.2-php7.2 php7.2
yum install -y httpd lynx
systemctl start httpd && systemctl enable httpd
mkdir /var/www/inc
curl -o /var/www/inc/dbinfo.inc https://cloudneta-book.s3.ap-northeast-2.amazonaws.com/chapter8/dbinfo.inc
curl -o /var/www/html/db.php https://cloudneta-book.s3.ap-northeast-2.amazonaws.com/chapter8/db.php
sed -i "s/dbsrv.idcseoul.internal/${db_address}/g" /var/www/html/db.php
sed -i "s/gasida/${db_user}/g" /var/www/html/db.php
sed -i "s/qwe123/${db_password}/g" /var/www/html/db.php
rm -rf /var/www/html/index.html
echo "<h1>CloudNet@ FullLab - SeoulRegion - Websrv1</h1>" > /var/www/html/index.html
echo "<h1>ALB-DNS: ${alb_name} </h1>" >> /var/www/html/index.html
echo "<h1>DB-PORT: ${db_port}</h1>" >> /var/www/html/index.html
echo "<h1>DB-User: ${db_user}</h1>" >> /var/www/html/index.html