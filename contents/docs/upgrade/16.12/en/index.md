How to upgrade Hatohol on CentOS 7  from version 16.04 to version 16.12
=====================================================================================================

How to upgrade Hatohol
----------------------

### Stop of the Hatohol Server

Stop the Hatohol Server to upgrade.

Use the following commands to hatohol Server:

    # systemctl stop hatohol

### Upgrade the Hatohol

Use the following command to upgrade Hatohol-16.12:

    # yum update hatohol-server hatohol-web

### Upgrade Hatohol DB

Use the following command to upgrade Hatohol DB:

    $ mysql -u <User name of MySQL user> -p <User password of MySQL user> hatohol
    
    > alter table incident_histories modify column comment VARCHAR(32767);

Extends the comment column of the incident_histories table from 2048 characters to 32767 characters. The maximum number of characters when adding comments to the event that has occurred will increase. If you do not deal with this, the maximum number of characters for comments will be 2048 characters as before, but you can continue to use it without any problems.

### Start of Hatohol Server

Use the following command to start Hatohol:

    # systemctl start hatohol
    # systemctl restart httpd

