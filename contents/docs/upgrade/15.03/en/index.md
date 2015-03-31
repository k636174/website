About Upgrade on CentOS 6.5 (x86_64) from version 14.12 to version 15.03
========================================================================

15.03 doesn't support upgrade from previous version to itself.
If you want to save previos version datas, you get database backup by the following way, and import to database in different name. Otherwise, don't import and keep it intact.

## How to get backup

$ mysqldump -u <User name of MySQL root user> -p <Password of MySQL root user> <Old database name> > hatohol.sql

## How to import a backup to database in the different name

$ mysql -u <User name of MySaQL root user> -p <Password of MySQL root user> <New database name> < hatohol.sql
