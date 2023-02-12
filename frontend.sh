script_location=$(pwd) # We are trying to determine the current location using the pwd command
yum install nginx -y
systemctl enable nginx
systemctl start nginx
rm -rf /usr/share/nginx/html/*
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip
# shellcheck disable=SC2164
cd /usr/share/nginx/html
unzip /tmp/frontend.zip
cp ${script_location}/files/nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf # As we need to copy the files from current location to the prescribed location, we are declaring the pwd command.
systemctl restart nginx