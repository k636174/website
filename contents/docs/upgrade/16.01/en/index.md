How to upgrade Hatohol on CentOS 7  from version 15.06 to version 16.01 with yum repository
=====================================================================================================

How to upgrade Hatohol
----------------------

### Stop of the Hatohol Server

Stop the Hatohol Server to upgrade.

Use the following commands to hatohol Server.

    # systemctl stop hatohol

### Upgrade the Hatohol

Use the following command to upgrade Hatohol-16.01.

    # yum update hatohol-server hatohol-web

### Upgrade Hatohol DB

Use the following command to upgrade Hatohol DB.

    $ hatohol-db-initiator -f --db-user <User name of MySQL user> --db-password <User password of MySQL user>

 - If the root password of the MySQL server is not set, just pass '' for --db-password.

### Upgrade Hatohol Web DB

Use the following command to reset Hatohol Web DB.

    # /usr/libexec/hatohol/client/manage.py syncdb

### Start of Hatohol Server

Use the following command to start Hatohol.

    # systemctl start hatohol
    # systemctl restart httpd

### Access Hatohol Web

Hatohol Web URL is changed since this version.

Please access to the following URL with Web browser.

`http://IP_ADDRESS or HOST_NAME/hatohol`
