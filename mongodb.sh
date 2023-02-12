script-location=$(pwd)

cp ${script_location}/files/mongo.repo /etc/yum.repos.d/mongodb.repo # We are copying the .repo file to the yum repo

yum install mongodb-org -y

systemctl enable mongod
systemctl restart mongod