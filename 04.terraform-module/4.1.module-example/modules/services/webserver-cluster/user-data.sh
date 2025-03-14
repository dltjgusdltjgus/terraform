#!/bin/bash
yum install -y httpd

cat > /var/www/html/index.html <<EOF
<h1>Hello, World</h1>
<p>DB address: ${db_address}</p>
<p>DB port: ${db_port}</p>
EOF

systemctl enable httpd  # 부팅 시 자동 시작
systemctl start httpd   # 즉시 실행

