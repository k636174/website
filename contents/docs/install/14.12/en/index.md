How to install Hatohol on CentOS 6.5 (x86_64) with yum repository
=================================================================

Installation of needed packages
-------------------------------
### Register the yum repository of Project hatohol.
Use the following command to save the repo file to /etc/yum.repos.d/ directory.

    # wget -P /etc/yum.repos.d/ http://project-hatohol.github.io/repo/hatohol.repo

### Register the yum repository of EPEL.
Use the following command to add EPEL repository.

    # rpm -ivh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm

### Install Hatohol Server
Use the following command to install Hatohol Server.

    # yum install hatohol-server

### Install Hatohol Web Frontend
Use the following command to install Hatohol Web.

    # yum install hatohol-web

### Dependent packages
The following packages are installed by the above commands.

- Provided packages from repository of CentOS 
    - glib2
    - libsoup
    - sqlite
    - mysql
    - libuuid
    - qpid-cpp-client
    - MySQL-python
    - httpd
    - mod_wsgi
    - python-argparse
- Provided package from repository of EPEL
    - librabbitmq
- Provided packages from repository of Project Hatohol
    - json-glib
    - Django

### Required packages
The following packages are required for Hatohol.

- Provided packages from repository of CentOS 
    - mysql-server
    - qpid-cpp-server

Use the following command to install MySQL and Apache Qpid servers.

    # yum install mysql-server qpid-cpp-server

Setup
-----
### Setup of MySQL server
If you have already used MySQL server and use it, you can omit following steps.  
Start MySQL server and start it when the machine is started.

    # chkconfig mysqld on
    # service mysqld start

### Initialization of Hatohol DB
Use following command to initialize Hatohol DB

    $ hatohol-db-initiator hatohol <User name of MySQL root user> <User password of MySQL root user>

Tips:

- If the root password of the MySQL server is not set, use "".
- You can change user name and password of the created DB by --hatohol-db-user and --hatohol-db-password options.
    - Then, You need to fix the /etc/hatohol/hatohol.conf

### Setup of Hatohol Client
- Prepare a DB for Hatohol Client

Use following commands in MySQL to create database and user.

    MySQL> CREATE DATABASE hatohol_client;
    MySQL> GRANT ALL PRIVILEGES ON hatohol_client.* TO hatohol@localhost IDENTIFIED BY 'hatohol';

- Add tables into the DB

Use following command to add tables into the db.

    # /usr/libexec/hatohol/client/manage.py syncdb

### Start of Hatohol server

    # service hatohol start

When Hatohol server successfully starts, init script shows following messages.

    Starting hatohol: [INFO] <ConfigManager.cc:429> Use configuration file: /etc/hatohol/hatohol.conf
    [INFO] <main.cc:171> started hatohol server: ver. 14.09

### Start of Hatohol Web

    # service httpd start

Access with a web browser
------------------------
### Check of the setting of iptables and SELinux
By default, some security mechanisms such as SELinux and iptables block the access from other computers.
You have to deactivate them if needed.
> ** WARNING **
> You should do the following things after you understand the security risk.

You can confirm the current SELinux status as

    # getenforce
    Enforcing

If 'Enforcing' is replied, it is enabled. And you can disable it as

    # setenforce 0
    # getenforce
    Permissive

> ** Tips **
> By editing /etc/selinux/config, it can be disabled permanently.

As for iptables, an allowed port can be added by editing /etc/sysconfig/iptables.
The following is an example to allow port 8000.

     -A INPUT -p icmp -j ACCEPT
     -A INPUT -i lo -j ACCEPT
     -A INPUT -m state --state NEW -m tcp -p tcp --dport 22 -j ACCEPT
    +-A INPUT -m state --state NEW -p tcp --dport 8000 -j ACCEPT
     -A INPUT -j REJECT --reject-with icmp-host-prohibited
     -A FORWARD -j REJECT --reject-with icmp-host-prohibited

> ** NOTE ** The mark '+' at the head means a newly added line.

Then, the following command reloads the iptables setting.

    # service iptables restart

### View of Hatohol information
For example, if the Hatohol client runs on computer: 192.168.1.1,
Open the following URL from your Browser.

- http://192.168.1.1/

> ** Note **
> Currently the above pages have been checked with Google Chrome and Firefox.
> When using Internet Explorer, display layouts may collapse depending on the version of use.

Use Hatohol Arm Plugin Interface
-------------------------------
When using HAPI(Hatohol Arm Plugin Interface), you fix '/etc/qpidd.conf' as the following.

    -auth=yes
    +auth=no

> ** NOTE ** The mark '+' at the head means a newly added line and the mark '-' at the head means a removed line.
