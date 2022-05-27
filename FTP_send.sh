#!/bin/sh

SERVER=""
USER=""
PASS=""
PORT="22"
DATE=$(date +%Y%m%d)
FILE_NAME="sqlbackupfile_${DATE}.tar"

echo "Plz Enter the target Server Address : "
read SERVER
echo "Plz Enter the target FTP server ID : "
read USER
echo "plz Enter the target FTP server PASSWORD : "
read PASS

echo "DONE! We will be send your back updata"
ftp -in -p $SERVER $PORT << EOF
     user $USER $PASS
  bin
      put $FILE_NAME
   bye
EOF
