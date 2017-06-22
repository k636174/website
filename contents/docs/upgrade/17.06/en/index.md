How to upgrade Hatohol on CentOS 7  from version 16.12 to version 17.06
=====================================================================================================

How to upgrade Hatohol
----------------------

### Stop of the Hatohol Server

Stop the Hatohol Server to upgrade.

Use the following commands to hatohol Server:

    # systemctl stop hatohol

### Upgrade the Hatohol

Use the following command to upgrade Hatohol-17.06:

    # yum update hatohol-server hatohol-web

### Start of Hatohol Server

Use the following command to start Hatohol:

    # systemctl start hatohol
    # systemctl restart httpd

