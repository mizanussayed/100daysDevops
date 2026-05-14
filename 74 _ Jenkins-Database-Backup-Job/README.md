# Day 74: Jenkins Database Backup Job

## 🎯 task
1. Create a Jenkins job named database-backup.


2. Configure it to take a database dump of the `kodekloud_db01` database present on the App server (stapp01) in Stratos Datacenter, the database user is `kodekloud_roy` and password is `asdfgdsd`.


3. The dump should be named in `db_$(date +%F).sql` format, where `date +%F` is the current date.

4. Copy the `db_$(date +%F).sql` dump to the Storage server (ststor01) under location /home/natasha/db_backups.


5. schedule this job to run periodically at */10 * * * * (please use this exact schedule format).

## 🧑‍💻 solution

1. check the database running on stapp01
```bash
# for mysql
mysql -u kodekloud_roy -p -e "show databases;"

# for postgresql
psql -U kodekloud_roy -c "\l"

# for oracle
sqlplus kodekloud_roy/asdfgdsd@stapp01:1521/ORCL -c "select name from v$database;"

# for sql server
sqlcmd -S stapp01 -U kodekloud_roy -P asdfgdsd -Q "SELECT name FROM sys.databases;"
```

## Create dump script and test it on stapp01
```bash
# dump the database
#mysqldump -u user -pYourPassword dbname > kodekloud_db01.sql
mysqldump -u kodekloud_roy -pasdfgdsd kodekloud_db01 > db_$(date +%F).sql

#copy the dump to storage server
ssh tony@stapp01 "mysqldump -u kodekloud_roy -pasdfgdsd kodekloud_db01 > /home/tony/db_\$(date +%F).sql"
scp tony@stapp01:/home/tony/db_$(date +%F).sql natasha@ststor01:/home/natasha/db_backups/
```