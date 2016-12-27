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

### Hatohol DBの更新

以下のコマンドを用いてHatohol ServerのDBをアップデートしてください。

    $ mysql -u <MySQLのユーザー名> -p <MySQLユーザーのパスワード> hatohol
    
    > alter table incident_histories modify column comment VARCHAR(32767);

TBL:incident_historiesのコメントカラムを2048文字から32767文字に拡張します。
発生したイベントにコメントを付与する場合、最大文字数が増えます。
この対処を行わない場合、コメントの最大文字数は今までどおり2048文字となりますが
特に支障なく使い続けることができます。


### Hatohol Serverの開始

以下のコマンドでHatoholを開始して下さい。

    # systemctl start hatohol
    # systemctl restart httpd

