#!/bin/bash
PATH_NAME=$(pwd)
DATE=$(date +%Y%m%d)
echo "please enter DB Root Acount ID :"
read ID
echo "name: $ID"
echo "please enter DB Root Acount PASSWORD :"
read PASSWORD
echo "======================back up process start =============================="
for DB in $(mysql -u ${ID} -p${PASSWORD} -e 'show databases' -s --skip-column-names); do 
	echo "$DB database back up now......"
	mysqldump -u ${ID} -p${PASSWORD} $DB > "$PATH_NAME"/backup/"$DB.sql"; 
	if [ $? = 1 ]; then 
		echo -e "\033[47;31m백업 실패 데이터베이스 명 : $DB \033[0m"
	else
		echo "$DB backup process is end...!"
	fi      
done    
echo "모든 데이터 베이스를 $PATH_NAME /backup 에 백업 완료 하였습니다."
echo "backup/ 디렉토리를 압축중... "
tar -civf sqlbackupfile_${DATE}.tar backup/ 
echo "==========================sqlbackupfile.tar List ================================"
tar tvf sqlbackupfile_${DATE}.tar
echo "기존 파일 삭제=> backup/*"
rm $PATH_NAME/backup/*
echo "삭제 완료"
echo "파일을 ftp를 통하여 다른 서버로 전송하시겠습니까? [y/n]"
read answer
if [ $answer == 'y' ]; then
	sh FTP_send.sh
fi
echo "프로세스 종료."
