source commoncode.sh

log=/tmp/roboshop.log

echo -e "\e[1;m Installing Nginx\e[0m"

yum install nginx -y >>${log}

status_check
rm -rf /usr/share/nginx/html/*
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip
cd /usr/share/nginx/html
unzip /tmp/frontend.zip
cp /usr/share/nginx/html /etc/nginx/default.d/roboshop.conf
systemctl enable nginx
systemctl restart nginx