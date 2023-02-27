source commoncode.sh

log=/tmp/roboshop.log

echo -e "\e[1;m Installing Nginx\e[0m"

yum install nginx -y >>${log}
status_check

echo -e "\e[1;m Removing Old files\e[0m"
rm -rf /usr/share/nginx/html/*
status_check

echo -e "\e[1; Downloading Frontend content\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip
status_check


# shellcheck disable=SC2164
cd /usr/share/nginx/html

echo -e "\e[1;m Extracting frontend content\e[0m"
unzip /tmp/frontend.zip
status_check

echo -e "\e[1;m Extracting frontend content\e[0m"
cp ${script_location}/practicefiles/roboshop.conf /etc/nginx/default.d/roboshop.conf
systemctl enable nginx
systemctl restart nginx