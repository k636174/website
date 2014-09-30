CentOS 6.5 (x86_64)でのyumレポジトリを用いたインストール方法
===========================================================

必要なパッケージのインストール
------------------------------
### Project Hatohol公式yumレポジトリの登録
以下のコマンドを実行し、Project Hatohol公式が提供するyumレポジトリの登録をしてください。

    # wget -P /etc/yum.repos.d/http://project-hatohol.github.io/repo/hatohol.repo

### EPELレポジトリの登録
以下のコマンドを実行し、EPELレポジトリの登録をしてください。

    # wget -P /etc/yum.repos.d/http://project-hatohol.github.io/repo/hatohol.repo

### Hatohol Serverのインストール
次のコマンドでインストールしてください。

    # yum install hatohol

### Hatohol Clientのインストール
次のコマンドでインストールしてください。

    # yum install hatohol-client

### 関連パッケージ
上記のコマンドでインストールされるパッケージは以下のとおりです。

- CentOSのレポジトリから提供されるパッケージ
    - glib2
    - libsoup
    - sqlite
    - mysql
    - mysql-server
    - libuuid
    - qpid-cpp-server
    - qpid-cpp-client
    - MySQL-python
    - httpd
    - mod_wsgi
- EPELのレポジトリから提供されるパッケージ
    - librabbitmq
- Project Hatoholのレポジトリから提供されるパッケージ
    - json-glib
    - Django

セットアップ
------------
### MySQL serverのセットアップ
すでにMySQL serverを使用している場合、このステップは省略できます。

    # chkconfig mysqld on
    # service mysqld start

### Hatohol DBの初期化
以下のコマンドを実行しHatohol DBを初期化してください。

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

### Hatohol Clientのセットアップ
- Hatohol Client用DBを用意する

以下のMySQLクエリを実行してデータベースとユーザを作成してください。

    MySQL> CREATE DATABASE hatohol_client;
    MySQL> GRANT ALL PRIVILEGES ON hatohol_client.* TO hatohol@localhost IDENTIFIED BY 'hatohol';

- テーブルをDBに追加する

以下のコマンドを実行してテーブルをDBの中に追加してください。

    # /usr/libexec/hatohol/client/managy.py syncdb

### Hatohol serverの開始

    # service hatohol start

Hatohol Serverが正常に開始した場合、起動スクリプトが以下のメッセージを表示されます。

    Starting hatohol: [INFO] <ConfigManager.cc:429> Use configuration file: /etc/hatohol/hatohol.conf
    [INFO] <main.cc:171> started hatohol server: ver. 14.09

### Hatohol Clientの開始

    # service httpd start

Webブラウザを使ったアクセス
--------------------------
### SELinuxとiptablesの設定確認
デフォルトでは、SELinuxやiptablesのようないくつかのセキュリティ機構によって他のコンピュータからのアクセスが妨げられます。
必要に応じて、それらを解除しなければなりません。

【警告】
下記の設定を行うにあたり、セキュリティリスクについてよく理解してください。

現在のSELinuxの状態は次のコマンドで確認できます。

    # getenforce
    Enforcing

もし'Enforcing'であれば、次のコマンドでSELinuxポリシールールの強制を解除できます。

    # setenforce 0
    # getenforce
    Permissive

【ヒント】  
/etc/selinux/configを編集することで、恒久的な無効化を行えます。

iptablesについては、/etc/sysconfig/iptablesの編集により許可ポートを追加できます。
下記は、8000番ポートを許可する例です。

      -A INPUT -p icmp -j ACCEPT
      -A INPUT -i lo -j ACCEPT
      -A INPUT -m state --state NEW -m tcp -p tcp --dport 22 -j ACCEPT
     +-A INPUT -m state --state NEW -p tcp --dport 8000 -j ACCEPT
      -A INPUT -j REJECT --reject-with icmp-host-prohibited
      -A FORWARD -j REJECT --reject-with icmp-host-prohibited

【メモ】  
先頭の'+'印は、新たに追加される行を意味します。

次のコマンドはiptablesの設定をリロードします。

    # service iptables restart

### Hatohol情報の閲覧
例えば、Hatohol clientが192.168.1.1で動作している場合、
ブラウザを用いて次のURLを開いてください。

- http://192.168.1.1/

hatohol-config.datで指定したユーザとパスワードでログインすることで、
各種画面の閲覧が可能になります。

【メモ】  
現在、上記ページは、Google ChromeおよびFirefoxを使ってチェックされています。
Internet Explorerを使用する場合は、ご使用のバージョンによっては、
表示レイアウトが崩れる場合があります。（IE11では正常に表示されることを確認しています）
