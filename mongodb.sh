source common.sh
script_location=$(pwd)

print_head "Copying MongoDB repo files"
cp ${script_location}/files/mongo.repo /etc/yum.repos.d/mongodb.repo &>>${log} # We are copying the .repo file to the yum repo
status_check

print_head "Installing MongoDB"
yum install mongodb-org -y &>>${log}
status_check

print_head "Changing the listen address"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf &>>${log}
status_check

print_head "Enabling MongoDB"
systemctl enable mongod &>>${log}
status_check

print_head "Starting MongoDB"
systemctl restart mongod &>>${log}
status_check