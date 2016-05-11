CentOS 7 (x86_64)での15.06から16.01へのyumを用いたアップグレード方法
=====================================================================

Hatoholのアップデート方法
-------------------------------

### Hatohol Serverの停止

アップデートするためにHatohol Serverを停止させます。

以下のコマンドでHatohol Serverを停止させてください。

    # systemctl stop hatohol

### アップデート方法

以下のコマンドを用いてHatoholを16.01へアップデートしてください。

    # yum update hatohol-server hatohol-web

### Hatohol DBの更新

以下のコマンドを用いてHatohol ServerのDBをアップデートしてください。

    $ hatohol-db-initiator -f --db-user <MySQLのユーザー名> --db-password <MySQLユーザーのパスワード>

- もしMySQLのrootパスワードが設定されていない場合、""を利用してください。

### Hatohol Web DBの更新

以下のコマンドでHatohol Web DBの再設定を行って下さい。

    # /usr/libexec/hatohol/client/manage.py syncdb

### Hatohol Serverの開始

以下のコマンドでHatoholを開始して下さい。

    # systemctl start hatohol
    # systemctl restart httpd

### Hatohol Webへのアクセス

ブラウザを用い、以下のURLからアクセスしてください。

`http://IP_ADDRESS or HOST_NAME/hatohol`
