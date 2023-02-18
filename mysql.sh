script_location=$(pwd)

dnf module disable mysql -y

cp ${script_location}/files/mysql.repo /etc/yum.repos.d/mysql.repo &>>${LOG}

mysql_secure_installation --set-root-pass RoboShop@1

mysql -uroot -pRoboShop@1

yum install mysql-community-server -y

systemctl enable mysqld

systemctl start mysqld