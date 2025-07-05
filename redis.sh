#!/bin/bash
source ./common.sh
app_name=redis

dnf module disable redis -y &>>$LOG_FILE
VALIDATE $? "Disabling redis module"

dnf module enable redis:7 -y &>>$LOG_FILE
VALIDATE $? "Enabling Redis:7"

dnf install redis
VALIDATE $? "Installing Redis"

sed -i -e 's/127.0.0.1/0.0.0.0/g' -e '/protected-mode/ c protected-mode no' /etc/redis/redis.conf
VALIDATE $? "Edited redis conf to accenpt reremote connection" 

systemctl enable redis &>>$LOG_FILE
VALIDATE $? "Enabling redis service"

systemctl start redis &>>$LOG_FILE
VALIDATE $? "Starting redis service"

print_time