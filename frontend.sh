source common.sh

script_location=$(pwd)

print_head "Installing Nginx"
yum install nginx -y
status_check

print_head "Removing default files"
rm -rf /usr/share/nginx/html/*
status_check

print_head "Downloading frontend content"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip
status_check

# shellcheck disable=SC2164
cd /usr/share/nginx/html

print_head "Extracting the frontend content"
unzip /tmp/frontend.zip
status_check

print_head "Copying the files to default location"
# shellcheck disable=SC1083
# shellcheck disable=SC2164
cp ${script_location}/files/nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf
status_check

print_head "Enabling Nginx"
systemctl enable nginx
status_check

print_head "Starting Nginx"
systemctl start nginx
status_check