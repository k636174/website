How to upgrade Hatohol on CentOS 6.5 (x86_64) from version 14.06 to version 14.09 with yum repository
=====================================================================================================

How to upgrade Hatohol
----------------------

### Stop of the Hatohol Server
Stop the Hatohol Server to upgrade.

Use the following commands to hatohol Server.

    # service hatohol stop
    # service httpd stop

### Upgrade the Hatohol

Use the following command to upgrade Hatohol.

    # yum upgrade hatohol hatohol-client

### Start of Hatohol Server

Use the following command to start Hatohol.

    # service hatohol start
    # service httpd start

When Hatohol server successfully starts, init script shows following messages.

    Starting hatohol: [INFO] <ConfigManager.cc:429> Use configuration file: /etc/hatohol/hatohol.conf
    [INFO] <main.cc:171> started hatohol server: ver. 14.09

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

