script_location=$(pwd) # We are trying to determine the current location using the pwd command
log=/tmp/roboshop.log #Assigning the log file to direct all the logs.

echo -e "\e[32m Installing Nginx \e[0m"
yum install nginx -y | bash &>>${log}

echo -e "\e[32m Removing default files \e[0m"
rm -rf /usr/share/nginx/html/* | bash &>>${log}

echo -e "\e[32m Downloading frontend content \e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip | bash &>>${log}

echo -e "\e[32m Creating Nginx directory \e[0m"
# shellcheck disable=SC2164
cd /usr/share/nginx/html | bash &>>${log}

echo -e "\e[32m Extracting the content \e[0m"
unzip /tmp/frontend.zip | bash &>>${log}

echo -e "\e[32m Copying the conf file to the default location \e[0m"
cp ${script_location}/files/nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf | bash &>>${log} # As we need to copy the files from current location to the prescribed location, we are declaring the pwd command.

echo -e "\e[32m Enabling Nginx \e[0m"
systemctl enable nginx | bash &>>${log}

echo -e "\e[32m Starting Nginx \e[0m"
systemctl restart nginx | bash &>>${log}