script_location=${pwd}

log=/tmp/roboshop.log

status_check() {
if [ $? -eq 0 ]; then
  echo -e "\e[1;32m Successful\e[0m"
   else
  echo -e "\e[1;31m Failure\e[0m"
  echo "Kindly refer the log file for more information, log - ${log}"
fi
exit
}

print_head() {
  echo -e "\e[1; $1 \e[0m"
}