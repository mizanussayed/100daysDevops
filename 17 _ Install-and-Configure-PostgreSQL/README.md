# Day 17: Install and Configure PostgreSQL

PostgreSQL database is already installed on the Nautilus database server.
a. Create a database user kodekloud_tim and set its password to LQfKeWWxWD.
b. Create a database kodekloud_db7 and grant full permissions to user kodekloud_tim on this database.

Note: Please do not try to restart PostgreSQL server service.

```bash
sudo -i -u postgres

psql
CREATE USER kodekloud_tim WITH PASSWORD 'LQfKeWWxWD';
CREATE DATABASE kodekloud_db7;
GRANT ALL PRIVILEGES ON DATABASE kodekloud_db7 TO kodekloud_tim;

\l -- database list
\du -- user list (role)
\q -- quit from sql;
```