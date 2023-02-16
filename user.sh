source common.sh
script_location=${pwd}

echo -e "\e[1;m Downloading repo files\e[0"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>{log}
status_check

echo -e "\e[1;m Installing NodeJS\e[0"
yum install nodejs -y &>>{log}

echo -e "\e[1; Adding user\e[0"
if [ $? -ne 0 ]; then
useradd roboshop &>>{log}
fi

mkdir -p /app

curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip &>>{log}
status_check

rm -rf /app/* &>>{log}
status_check


# shellcheck disable=SC2164
cd /app
unzip /tmp/user.zip
status_check

# shellcheck disable=SC2164
cp {script_location}/files/user.service /etc/systemd/system/user.service
status_check

npm install
status_check

systemctl daemon-reload
status_check

systemctl enable user
status_check

systemctl start user
status_check

yum install mongodb-org-shell -y
status_check

mongo --host MONGODB-SERVER-IPADDRESS </app/schema/user.js
status_check