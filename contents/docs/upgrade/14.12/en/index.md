How to upgrade Hatohol on CentOS 6.5 (x86_64) from version 14.09 to version 14.12 with yum repository
=====================================================================================================

How to upgrade Hatohol
----------------------

### Stop of the Hatohol Server
Stop the Hatohol Server to upgrade.

Use the following commands to hatohol Server.

    # service hatohol stop

### Upgrade the Hatohol
You can not heretofore update by yum upgrade, because we changed packages name since this update.
Each packages name are changed as the following.

    hatohol -> hatohol-server
    hatohol-client -> hatohol-web
    hatohol-arm-plugin-zabbix -> hatohol-arm-zabbix
    hatohol-lib-arm-plugin -> hatohol-lib-arm

Install Hatohol-14.12 after uninstall Hatohol-14.09.
Use the following command to uninstall Hatohol-14.09.

    # yum remove hatohol hatohol-client hatohol-lib-common

Use the following command to install Hatohol-14.12 after finish uninstall.

    # yum install hatohol-server hatohol-web

### Upgrade Hatohol DB
If you upgrade it from 14.09, please update the monitoring server type definitions by the following command:

   $ hatohol-db-initiator -f -t server_types hatohol <User name of MySQL user> <User password of MySQL user>

### Upgrade Hatohol Web DB
Use the following command to reset up Hatohol Web DB.

    # /usr/libexec/hatohol/client/manage.py syncdb

### Start of Hatohol Server
Use the following command to start Hatohol.

    # service hatohol start
    # service httpd restart

When Hatohol server successfully starts, init script shows following messages.

    Starting hatohol: [INFO] <ConfigManager.cc:429> Use configuration file: /etc/hatohol/hatohol.conf
    [INFO] <main.cc:171> started hatohol server: ver. 14.12

NOTE
----

### hatohol-config-db-creator command was removed
We remove the hatohol-config-db-creator command to initialize DB of Hatohol.  
But, we add the hatohol-db-initiator command to initialize DB instead of it.  
And, you can not add monitoring server information and incident management server information by hatohol-db-initiator.
You need use web interface to add these information.

Usage:

    $ hatohol-db-initiator hatohol <User name of MySQL root user> <Password of MySQL root user>

NOTE:  
If you meat the following error,

    ImportError: No module named argparse

Use following command to install require package.

    # yum install python-argparse

Tips:

- If the root password of the MySQL server is not set, use "".
- You can change user name and password of the created DB by --hatohol-db-user and --hatohol-db-password options.
    - Then, You need to fix the /etc/hatohol/hatohol.conf

