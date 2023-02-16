script_location=$(pwd)

print_head "Downloading configuration files"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>{log}
status_code

yum install nodejs -y
status_code

id useradd
if [ $? -ne 0 ]; then
useradd roboshop
fi
status_code

mkdir -p /app
status_code

curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip
status_code

cd /app
unzip /tmp/user.zip
status_code

cd /app
npm install
status_code

cp "${script_location}"/files/user.service /etc/systemd/system/user.service
status_code

systemctl daemon-reload
status_code

systemctl enable user
status_code
systemctl start user
status_code
yum install mongodb-org-shell -y
status_code
mongo --host localhost </app/schema/user.js
status_code
