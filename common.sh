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
  curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${log}
  status_check

  print_head "Cleanup Old Content"
  rm -rf /app/* &>>${log}
  status_check

  print_head "Extracting App Content"
  cd /app
  unzip /tmp/${component}.zip &>>${log}
  status_check
}