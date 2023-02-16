source common.sh
script_location=${pwd}

echo -e "\e[1;m Downloading repo files\e[0"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

if [ $? -eq 0 ]; then
  echo -e "\e[1;32m Successful\e[0"
  else
  echo -e "\e[1;31m Fail\e[0"
  exit
fi

echo -e "\e[1;m Installing NodeJS\e[0"
yum install nodejs -y

echo -e "\e[1; Adding user\e[0"
if [ $? -ne 0 ]; then
useradd roboshop
fi

mkdir -p /app

if [ $? -eq 0 ]; then
  echo -e "\e[1;32m Successful\e[0"
  else
  echo -e "\e[1;31m Fail\e[0"
fi

curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip

if [ $? -eq 0 ]; then
  echo -e "\e[1;32m Successful\e[0"
  else
  echo -e "\e[1;31m Fail\e[0"
fi

rm -rf /app/*

if [ $? -eq 0 ]; then
  echo -e "\e[1;32m Successful\e[0"
  else
  echo -e "\e[1;31m Fail\e[0"
fi


# shellcheck disable=SC2164
cd /app
unzip /tmp/user.zip

if [ $? -eq 0 ]; then
  echo -e "\e[1;32m Successful\e[0"
  else
  echo -e "\e[1;31m Fail\e[0"
fi

cp {script_location}/files/user.service /etc/systemd/system/user.service

if [ $? -eq 0 ]; then
  echo -e "\e[1;32m Successful\e[0"
  else
  echo -e "\e[1;31m Fail\e[0"
fi

npm install

if [ $? -eq 0 ]; then
  echo -e "\e[1;32m Successful\e[0"
  else
  echo -e "\e[1;31m Fail\e[0"
fi

systemctl daemon-reload
if [ $? -eq 0 ]; then
  echo -e "\e[1;32m Successful\e[0"
  else
  echo -e "\e[1;31m Fail\e[0"
fi
systemctl enable user
if [ $? -eq 0 ]; then
  echo -e "\e[1;32m Successful\e[0"
  else
  echo -e "\e[1;31m Fail\e[0"
fi
systemctl start user
if [ $? -eq 0 ]; then
  echo -e "\e[1;32m Successful\e[0"
  else
  echo -e "\e[1;31m Fail\e[0"
fi
yum install mongodb-org-shell -y
if [ $? -eq 0 ]; then
  echo -e "\e[1;32m Successful\e[0"
  else
  echo -e "\e[1;31m Fail\e[0"
fi
mongo --host MONGODB-SERVER-IPADDRESS </app/schema/user.js
if [ $? -eq 0 ]; then
  echo -e "\e[1;32m Successful\e[0"
  else
  echo -e "\e[1;31m Fail\e[0"
  exit
fi
