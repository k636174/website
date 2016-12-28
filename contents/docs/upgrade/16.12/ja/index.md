CentOS 7 (x86_64)での16.04から16.12へのアップグレード方法
=====================================================================

Hatoholのアップデート方法
-------------------------------

### Hatohol Serverの停止

アップデートするためにHatohol Serverを停止させます。

以下のコマンドでHatohol Serverを停止させてください。

    # systemctl stop hatohol

### アップデート方法

以下のコマンドを用いてHatoholを16.12へアップデートしてください。

    # yum update hatohol-server hatohol-web

### Hatohol Serverの開始

以下のコマンドでHatoholを開始して下さい。

    # systemctl start hatohol
    # systemctl restart httpd

