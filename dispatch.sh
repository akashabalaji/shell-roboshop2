#!/bin/bash
source ./common.sh
app_name=dispatch

check_root
dnf install golang -y &>>$LOG_FILE
VALIDATE $? "Installing golang"

app_setup

go mod init dispatch &>>$LOG_FILE
VALIDATE $? "Initializing go module"

go get &>>$LOG_FILE
VALIDATE $? "Installing go dependencies"

go build &>>$LOG_FILE
VALIDATE $? "Building go application"

cp $SCRIPT_DIR/dispatch.service /etc/systemd/system/dispatch.service
print_time