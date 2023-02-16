source common.sh

script_location=$(pwd)

print_head "Downloading NodeJS"
curl -sL https://rpm.nodesource.com/setup_lts.x &>>${log}
status_check

print_head "Installing NodeJS"
yum install nodejs -y &>>${log}
status_check

print_head "Adding user"
if [ $? -ne 0 ]; then
useradd roboshop &>>${log}
fi
status_check

print_head "making the new directory"
mkdir -p /app &>>${log}
status_check

print_head "Downloading catalogue content"
curl -L -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>${log}
status_check

print_head "Removing previous files, if any"
rm -rf /app/* &>>${log}
status_check

print_head "Extracting the content"
# shellcheck disable=SC2164
cd /app
unzip /tmp/catalogue.zip &>>${log}
status_check

# shellcheck disable=SC2164
cd /app
status_check

print_head "Installing NPM"
npm install &>>${log}
status_check

print_head "Moving the extracted files to the default location"
cp ${script_location}/files/catalogue.service /etc/systemd/system/catalogue.service &>>${log}
status_check

print_head "Loading user"
systemctl daemon-reload &>>${log}
status_check

print_head "Installing MongoDB client "
# We are installing the mongo client as it was already downloaded
yum install mongodb-org-shell -y &>>${log}
mongo --host localhost </app/schema/catalogue.js &>>${log}
status_check

print_head "Enabling Catalogue"
systemctl enable catalogue &>>${log}
status_check

print_head "Starting Catalogue"
systemctl start catalogue &>>${log}
status_check


