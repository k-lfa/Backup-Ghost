# BackupGhost

Script to save ghost Website =>

1. Dump MySQL database of ghost
2. Copy the Folder of Ghost CMS App (/var/www/ghost)
3. Make an archive
3. Check If error


To execute login in root
don't forget to insert your password in variable sqlpass=
For Example :

sqlpass="IamSup3rP@$$"

Do not put the root password for security ! Put the password of user dedicated for the database ;)
Check your database name, by default in the script is "ghost"

For execute -> 
chmod 700 backupghost.sh
./backupghost.sh

Good Backup and Enjoy :)
