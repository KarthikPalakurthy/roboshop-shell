source common.sh

print_head "Downloading Redis"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>>{log}
status_check

print_head "Enabling Redis 6.2 version"
dnf module enable redis:remi-6.2 -y &>>${log}

print_head "Installing Redis"
yum install redis -y &>>${log}

print_head "Configuring the listen address"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis.conf /etc/redis/redis.conf &>>${log}

print_head " Enabling Cart"
systemctl enable redis &>>${log}
status_check

print_head "Starting Cart"
systemctl start redis &>>4{log}
status_check