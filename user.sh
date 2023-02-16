source common.sh

script_location=${pwd}

print_head "Add Application User"
id roboshop &>>${LOG}
  if [ $? -ne 0 ]; then
    useradd roboshop &>>${LOG}
  fi
status_check

  mkdir -p /app &>>${LOG}

print_head "Downloading App content"
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip &>>${LOG}
status_check

print_head "Cleanup Old Content"
rm -rf /app/* &>>${LOG}
status_check

print_head "Extracting App Content"
cd /app
unzip /tmp/user.zip &>>${LOG}
status_check

print_head "Configuring user Service File"
  cp ${script_location}/files/user.service /etc/systemd/system/user.service &>>${LOG}
  status_check

  print_head "Reload SystemD"
  systemctl daemon-reload &>>${LOG}
  status_check

  print_head "Enable user Service "
  systemctl enable user &>>${LOG}
  status_check

  print_head "Start user service "
  systemctl start user &>>${LOG}
  status_check