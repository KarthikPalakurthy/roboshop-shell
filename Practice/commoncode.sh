script_location=$(pwd)

status_check() {

if [ $? -eq 0 ]; then
 echo -e "\e[1;32m Successful\e[0m"
 else
 echo -e "\e[1;31m Failure\e[0m"
 fi
}

