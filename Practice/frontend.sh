source commoncode.sh
yum install nginx -y >>${log}
status_check
rm -rf /usr/share/nginx/html/*
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip
cd /usr/share/nginx/html
unzip /tmp/frontend.zip
cp /usr/share/nginx/html /etc/nginx/default.d/roboshop.conf
systemctl enable nginx
systemctl restart nginx