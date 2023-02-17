script_location=$(pwd)

log=/tmp/roboshop.log

status_check() {
if [ $? -eq 0 ]; then
  echo -e "\e[1;32m Successful\e[0m"
   else
  echo -e "\e[1;31m Failure\e[0m"
  echo "Kindly refer the log file for more information, log - ${log}"
  exit 1
fi
}

print_head() {
  echo -e "\e[1;m $1 \e[0m"
}

APP_PREREQ() {

  print_head "Add Application User"
  id roboshop &>>${log}
  if [ $? -ne 0 ]; then
    useradd roboshop &>>${log}
  fi
  status_check

  mkdir -p /app &>>${log}

  print_head "Downloading App content"
  # shellcheck disable=SC2154
  curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${log}
  status_check

  print_head "Cleanup Old Content"
  rm -rf /app/* &>>${log}
  status_check

  print_head "Extracting App Content"
  # shellcheck disable=SC2164
  cd /app
  unzip /tmp/${component}.zip &>>${log}
  status_check
}

NODEJS() {

  print_head "Configuring NodeJS Repos"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log}
  status_check

  print_head "Install NodeJS"
  yum install nodejs -y &>>${log}
  status_check

  APP_PREREQ

  # shellcheck disable=SC2164
  cd /app

  print_head "Installing NodeJS dependencies"
  npm install &>>${log}
  status_check

}

SCHEMA() {

print_head "Configuring {component} service file"
cp ${script_location}/files/{component}.service /etc/systemd/system/{component}.service &>>${log}
status_check

print_head "Reloading SystemD"
systemctl daemon-reload &>>${log}
status_check

print_head "Installing MongoDB client "
# We are installing the mongo client as it was already downloaded
yum install mongodb-org-shell -y &>>${log}
status_check

print_head "Enabling {component}"
systemctl enable {component} &>>${log}
status_check

print_head "Starting {component}"
systemctl start {component} &>>${log}
status_check

print_head "Loading Schema"
mongo --host localhost </app/schema/{component}.js &>>${log}
status_check

}