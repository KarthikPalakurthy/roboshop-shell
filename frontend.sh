source common.sh

print_head "Install Nginx"
yum install nginx -y &>>${log}
status_check

print_head "Remove Nginx Old Content"
rm -rf /usr/share/nginx/html/* &>>${log}
status_check


print_head "Download Frontend Content"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>${log}
status_check

cd /usr/share/nginx/html &>>${log}

print_head "Extract Frontend Content"
unzip /tmp/frontend.zip &>>${log}
status_check

print_head "Copy RoboShop Nginx Config File"
cp ${script_location}/files/nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf &>>${log}
status_check

print_head "Enable Nginx"
systemctl enable nginx &>>${log}
status_check

print_head "Start Nginx"
systemctl restart nginx &>>${log}
status_check

