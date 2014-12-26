CentOS 6.5 (x86_64)での14.09から14.12へのyumを用いたアップグレード方法
=====================================================================

Hatoholのアップデート方法
-------------------------------
### Hatohol Serverの停止
アップデートするためにHatohol Serverを停止させます。

以下のコマンドでHatohol Serverを停止させてください。

    # service hatohol stop

### アップデート方法
今回のアップデートでパッケージ名が変更されたため、従来のyum upgradeコマンドによるアップデートは行えません。

以下のようにそれぞれパッケージ名が変更されました。

    hatohol -> hatohol-server
    hatohol-client -> hatohol-web
    hatohol-arm-plugin-zabbix -> hatohol-arm-zabbix
    hatohol-lib-arm-plugin -> hatohol-lib-arm

一度Hatohol-14.09をアンインストールした後に、Hatohol-14.12をインストールします。
以下のコマンドを用いてHatohol-14.09をアンインストールしてください。

    # yum remove hatohol hatohol-client hatohol-lib-common

アンインストールが完了した後に、以下のコマンドを用いてHatohol-14.12をインストールしてください。

    # yum install hatohol-server hatohol-web

### Hatohol Web DBの設定
以下のコマンドでHatohol Web DBの再設定を行って下さい。

    # /usr/libexec/hatohol/client/manage.py syncdb

### Hatohol Serverの開始
以下のコマンドでHatoholを開始して下さい。

    # service hatohol start
    # service httpd restart

Hatohol serverが正常に開始した場合、以下のようなメッセージが表示されます。

    Starting hatohol: [INFO] <ConfigManager.cc:429> Use configuration file: /etc/hatohol/hatohol.conf
    [INFO] <main.cc:171> started hatohol server: ver. 14.12

注意
---
### hatohol-config-db-creatorコマンドは廃止されました
HatoholのDBを初期化するためのhatohol-config-db-creatorコマンドを削除しました。  
しかし、その代わりにhatohol-db-initiatorコマンドを追加しました。  
そして、監視サーバ情報やインシデント管理サーバ情報の登録はhatohol-db-initiatorコマンドによって追加することが不可能になりました。  
それらの情報を登録するにはWEBインターフェースを利用して下さい。

使用方法:

    $ hatohol-db-initiator hatohol <MySQLのrootユーザ名> <MySQLのrootパスワード>

情報:  
もし、以下のエラーが発生した場合、

    ImportError: No module named argparse

以下のコマンドを実行して必要なパッケージをインストールしてください。

    # yum install python-argparse

TIPS:

- もしMySQLのrootパスワードが指定されていない場合、""を利用してください。
- 生成されるDBのユーザ名とパスワードを--hatohol-db-userと--hatohol-db-passwordオプションを利用して変更することができます。
    - その時は/etc/hatohol/hatohol.confファイルを修正してください。

