script_location=$(pwd)
set -e

curl -sL https://rpm.nodesource.com/setup_lts.x | bash

yum install nodejs -y

if [ $? -ne 0 ]; then
useradd roboshop
fi

mkdir -p /app

curl -L -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip

# shellcheck disable=SC2164
cd /app
unzip /tmp/catalogue.zip

# shellcheck disable=SC2164
cd /app

npm install

cp ${script_location}/files/catalogue.service /etc/systemd/system/catalogue.service

systemctl daemon-reload

systemctl enable catalogue

systemctl start catalogue

# We are installing the mongo client as it was already downloaded
yum install mongodb-org-shell -y
mongo --host localhost </app/schema/catalogue.js

