#!/bin/sh

USR="devops"

for host in `cat remotehosts`
do
	echo "############################"
	echo "Connecting to $host"
	echo "pushing script to $host"
	scp multios_websetup.sh $USR@$host:/tmp
	echo "Executing script on $host"
	ssh $USR@$host sudo /tmp/multios_websetup.sh
	echo "Removing the tmp files"
	ssh $USR@$host sudo rm -rf /tmp/multios_websetup.sh
	echo "############################"
done
