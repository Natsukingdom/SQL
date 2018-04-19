# setup

1. install mysql
1. create user
   ```sql
   grant all privileges on *.* to 'hoge'@'localhost'
   identified by 'password';
   ```
1. login
1. create database
   ```sql
   create database bank;
   ```
1. use database of bank
   ```sql
   use bank;
   ```
1. import `practice_dump.sql`
   ```sql
   source path/to/practice_dump.sql
   ```
