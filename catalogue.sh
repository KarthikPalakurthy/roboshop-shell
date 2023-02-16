source common.sh

script_location=$(pwd)

print_head "Downloading NodeJS"
curl -sL https://rpm.nodesource.com/setup_lts.x &>>${log}
status_check

print_head "Installing NodeJS"
yum install nodejs -y &>>${log}
status_check

print_head "Adding Application user"
if [ $? -ne 0 ]; then
useradd roboshop &>>${log}
fi
status_check

mkdir -p /app &>>${log}

print_head "Downloading Application content"
curl -L -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>${log}
status_check

print_head "Removing previous files, if any"
rm -rf /app/* &>>${log}
status_check

print_head "Extracting App content"
# shellcheck disable=SC2164
cd /app
unzip /tmp/catalogue.zip &>>${log}
status_check

# shellcheck disable=SC2164
cd /app
status_check

print_head "Installing NodeJS dependencies"
npm install &>>${log}
status_check

print_head "Configuring Catalogue service file"
cp ${script_location}/files/catalogue.service /etc/systemd/system/catalogue.service &>>${log}
status_check

print_head "Reloading SystemD"
systemctl daemon-reload &>>${log}
status_check

print_head "Installing MongoDB client "
# We are installing the mongo client as it was already downloaded
yum install mongodb-org-shell -y &>>${log}
status_check

print_head "Enabling Catalogue"
systemctl enable catalogue &>>${log}
status_check

print_head "Starting Catalogue"
systemctl start catalogue &>>${log}
status_check

print_head "Loading Schema"
mongo --host localhost </app/schema/catalogue.js &>>${log}
status_check
