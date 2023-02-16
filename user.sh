source common.sh

script_location=$(pwd)

print_head "Downloading configuration files"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>{log}
status_check

yum install nodejs -y
status_check

id useradd
if [ $? -ne 0 ]; then
useradd roboshop
fi
status_check

mkdir -p /app
status_check

curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip
status_check

cd /app
unzip /tmp/user.zip
status_check

cd /app
npm install
status_check

cp "${script_location}"/files/user.service /etc/systemd/system/user.service
status_check

systemctl daemon-reload
status_check

systemctl enable user
status_check
systemctl start user
status_check
yum install mongodb-org-shell -y
status_check
mongo --host localhost </app/schema/user.js
status_check
