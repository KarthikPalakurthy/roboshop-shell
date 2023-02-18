script_location=$(pwd)

dnf module disable mysql -y

cp ${script_location}/files/mysql.repo /etc/yum.repos.d/mysql.repo &>>${LOG}

yum install mysql-community-server -y

systemctl enable mysqld

systemctl start mysqld