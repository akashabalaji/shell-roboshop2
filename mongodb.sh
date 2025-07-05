#!/bin/bash
source ./common.sh
app_name=mongodb

check_root
cp mongo.repo /etc/yum.repos.d/mongo.repo
VALIDATE $? "Copying MongoDB repo file"

dnf install mongodb-org -y &>>$LOG_FILE
VALIDATE $? "Installing MongoDB"

systemctl enable mongod &>>$LOG_FILE
VALIDATE $? "Enabling MongoDB service"

systemctl start mongod &>>$LOG_FILE
VALIDATE $? "Starting MongoDB service"

sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf # This line allows remote connections to MongoDB
VALIDATE $? "Editing MongoDB conf file for remote connection"

systemctl restart mongod &>>$LOG_FILE
VALIDATE $? "Restarting MongoDB service"
print_time