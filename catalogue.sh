script_location=$(pwd)
set -e

curl -sL https://rpm.nodesource.com/setup_lts.x &>>${log}
status_check

yum install nodejs -y
status_check

if [ $? -ne 0 ]; then
useradd roboshop
fi
status_check

mkdir -p /app
status_check

curl -L -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
status_check

rm -rf /app/*
status_check

# shellcheck disable=SC2164
cd /app
unzip /tmp/catalogue.zip
status_check

# shellcheck disable=SC2164
cd /app
status_check

npm install
status_check

cp ${script_location}/files/catalogue.service /etc/systemd/system/catalogue.service
status_check

systemctl daemon-reload
status_check

systemctl enable catalogue
status_check

systemctl start catalogue
status_check

# We are installing the mongo client as it was already downloaded
yum install mongodb-org-shell -y
mongo --host localhost </app/schema/catalogue.js
status_check

