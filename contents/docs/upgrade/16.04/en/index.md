About Upgrade on CentOS 7 (x86_64) from version 16.01 to version 16.04
========================================================================

## ***16.04 doesn't support upgrade from previous version.***

If you want to save data of previous version, you get DB backup by the following way, and import to DB in different name. Otherwise, don't import and keep it intact.

## Removed ArmXXX

Built-in Arm retrieving mechanism has been removed from hatohol server in this release.

Please get use the monitoring data by Hatohol Arm Plugin2. 

## How to get backup

    $ mysqldump -u [User name of MySQL root user] -p [Password of MySQL root user] [Old DB name] > hatohol.sql

## How to import a backup to DB in the different name

    $ mysql -u [User name of MySQL root user] -p [Password of MySQL root user] [New DB name] < hatohol.sql
