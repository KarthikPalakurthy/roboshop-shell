source common.sh

script_location=$pwd

print_head "Add Application User"
id roboshop &>>${log}
  if [ $? -ne 0 ]; then
    useradd roboshop &>>${log}
  fi
status_check

  mkdir -p /app &>>${log}

print_head "Downloading App content"
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip &>>${log}
status_check

print_head "Cleanup Old Content"
rm -rf /app/* &>>${log}
status_check

print_head "Extracting App Content"
cd /app
unzip /tmp/user.zip &>>${log}
status_check

print_head "Configuring user Service File"
# shellcheck disable=SC1083
# shellcheck disable=SC2164
  cp ${script_location}/files/user.service /etc/systemd/system/user.service &>>${log}
  status_check

  print_head "Reload SystemD"
  systemctl daemon-reload &>>${log}
  status_check

  print_head "Enable user Service "
  systemctl enable user &>>${log}
  status_check

  print_head "Start user service "
  systemctl start user &>>${log}
  status_check