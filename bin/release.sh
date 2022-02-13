#!/bin/sh

CURRENT_DIR=$(cd `dirname $0`; pwd)
PARENT_DIR=${CURRENT_DIR%/*}
BASE_DIR=${PARENT_DIR%/*}

API_DIR=$BASE_DIR"/report"

mvn clean package -f $API_DIR"/pom.xml" -DskipTests
if [ $? -eq 1 ]; then
	echo "Package report failed"
	exit 1
fi

scp $API_DIR"/target/report.war" root@121.89.166.67:/var/tmp/report
echo "scp report success... \n"
ssh root@121.89.166.67 "cd /var/tmp/report && sh restart.sh"