script_location=${pwd}

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

component () {

  print_head "Copying {component} repo files"
  cp ${script_location}/files/{component}.repo /etc/yum.repos.d/{component}.repo &>>${log} # We are copying the .repo file to the yum repo
  status_check

  print_head "Installing {component}"
  yum install mongodb-org -y &>>${log}
  status_check

  print_head "Changing the listen address"
  sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/{component}.conf &>>${log}
  status_check

  print_head "Enabling {component}"
  systemctl enable {component} &>>${log}
  status_check

  print_head "Starting {component}"
  systemctl restart {component} &>>${log}
  status_check

}