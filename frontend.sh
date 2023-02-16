

script_location=$(pwd)

print_head " Installing Nginx "
yum install nginx -y
{
if [ $? -eq 0 ]; then
  echo "Success"
   else
  echo "fail"
fi
}

rm -rf /usr/share/nginx/html/*
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip
# shellcheck disable=SC2164
cd /usr/share/nginx/html
unzip /tmp/frontend.zip

# shellcheck disable=SC1083
# shellcheck disable=SC2164
cp ${script_location}/files/nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf

systemctl enable nginx
systemctl start nginx