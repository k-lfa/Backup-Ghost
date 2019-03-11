#!/bin/bash

#######################################################################
#       Script to Backup Website Ghost K-lfa                          #
#######################################################################

DATE=$(date +%d-%m-%y) #put date in variable
LOG="/tmp/backupghost.log" #put path of log in variable
Path="/root/Backup_$DATE/" #put path of backup in variable
NbError=0 #start the number of errors count

if [ $(id | awk -F" " '{print $1}') != "uid=0(root)" ];then #Check if logged in root
       echo -e "\033[31;1mMust Be Root !\033[0m"       #if not root print error message and exit 1
       exit 1
fi

CheckError()	#Function to check error oo previous command
{
        if [ "$?"  != "0" ];then
                echo -e "\033[31;1mAn error ocurred\033[0m"
                NbError=$((NbError+1))	#If error count of error +1
        fi
}

CheckFolderExist()	#Function to check if backup folder already exist
{
	if [ -d "$Path" ];then
		echo -e "\033[31;1m$Path already exist\033[0m"
		exit 1
	fi
}

sqlpass=""	#Put your sql user's password
database="ghost"	#Put the name of your database ghost

echo -e "[+] Création du dossier /root/Backup_$DATE"
CheckFolderExist	#check if folder exist
mkdir $Path 2>>$LOG	#Create folder and log errors
CheckError		#check if error

echo -e "[+] Dump de la base SQL ghost"
mysqldump -u root -p$sqlpass $database > $Path/GhostBackup_$DATE.sql	#Dump of Mysql database ghost
CheckError	#check if error

echo -e "[+] Backup de l'appli Ghost CMS"
cp -a /var/www/ghost $Path 2>>$LOG	#copy the folder of ghost with attributes
CheckError				#check if errors
tar czf /root/Backup_$DATE.tar.gz $Path 2>>$LOG		#Make an archive of ghost folder
CheckError						#check if error
mv /root/Backup_$DATE.tar.gz $Path

if [ "$NbError" != "0" ];then	#If count of error isn't 0 print number of errors
        echo -e "\033[33;1mWarning $NbError errors occured\033[0m"
        exit 1
fi

echo -e "\033[32;1mSauvegarde OK en la date du $DATE\033[0m"	#Everything is OK
exit 0
