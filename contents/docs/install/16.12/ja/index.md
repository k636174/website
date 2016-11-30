CentOS7 (x86_64)でのyumレポジトリを用いたインストール方法
===========================================================
※このドキュメントは2016/11/30現在の情報を元に記載されています

必要なパッケージのインストール
------------------------------
### Project Hatohol公式yumレポジトリの登録
以下のコマンドを実行し、Project Hatohol公式が提供するyumレポジトリの登録をしてください。

    # wget -P /etc/yum.repos.d/ http://project-hatohol.github.io/repo/hatohol-el7.repo

### EPELレポジトリの登録
以下のコマンドを実行し、EPELレポジトリの登録をしてください。

    # yum install epel-release

### Hatohol Serverのインストール
次のコマンドでインストールしてください。

    # yum install hatohol-server

### Hatohol Web Frontendのインストール
次のコマンドでインストールしてください。

    # yum install hatohol-web

### 依存パッケージ
上記のコマンドでインストールされるパッケージは以下のとおりです。  
（これらのパッケージはyum install時に同時にインストールされます）

- CentOSのレポジトリから提供されるパッケージ
    - glib2
    - libsoup
    - sqlite
    - mariadb
    - libuuid
    - MySQL-python
    - httpd
    - mod_wsgi
    - python-argparse
    - python-pip
    - json-glib
    - Django
- EPELのレポジトリから提供されるパッケージ
    - librabbitmq

### 必要パッケージ
以下のパッケージがHatoholの正常な動作に必要です。

- CentOSのレポジトリから提供されるパッケージ
    - mariadb-server

次のコマンドでインストールしてください。

    # yum install mariadb-server

セットアップ
------------
### MariaDB serverのセットアップ
すでにMariaDB serverを使用している場合、このステップは省略できます。

    # systemctl enable mariadb
    # systemctl start mariadb

### Hatohol DBの初期化
以下のコマンドを実行しHatohol DBを初期化してください。

    $ hatohol-db-initiator --db-user <MariaDBのrootユーザー名> --db-password <MariaDBのrootパスワード>

TIPS:

- もしMariaDBのrootパスワードが指定されていない場合、""を利用してください。

- 生成されるDB名、ユーザ名、パスワードを--db-name, --hatohol-db-userと--hatohol-db-passwordオプションを利用して変更することができます。
    - /etc/hatohol/hatohol.confファイルを以下のように修正することによっても変更可能です。hatohol.confは${prefix}/etc/hatohol/hatohol.confに配置されています。

```
[mysql]
- database=hatohol
+ database=your DB name
- user=hatohol
+ user=user name of MariaDB root user
- password=hatohol
+ password= password of MariaDB root user

[FaceRest]
workers=4

** メモ **
先頭の'+'印は、新たに追加する行を意味します。
先頭の'-'印は、削除する行を意味します。
```

- hatohol-db-initiatorはhatoholデータベースを作成後はコマンドライン引数を必要としなくなりました。  
db-name、 db-userとdb-passwordはhatohol.confから読み込まれます。

### Hatohol Webのセットアップ
- Hatohol Web用DBを用意する

以下のMySQLクエリを実行してデータベースとユーザを作成してください。
（ここではhatohol@localhostユーザを作りパスワード'hatohol'を与えています。適宜変更してください。）

    MariaDB> CREATE DATABASE hatohol_client DEFAULT CHARACTER SET utf8;
    MariaDB> GRANT ALL PRIVILEGES ON hatohol_client.* TO hatohol@localhost IDENTIFIED BY 'hatohol';

- テーブルをDBに追加する

以下のコマンドを実行してテーブルをDBの中に追加してください。

    # /usr/libexec/hatohol/client/manage.py syncdb

### Hatohol Arm Plugin Interfaceの設定
Hatohol Arm Plugin(以下HAP)を使用するために以下のドキュメントを参照し、RabbitMQの設定とHAPのインストールを行ってください。

![HAPインストール手順](../../plugins/2.1/HowToUse_ja.md)

### Hatohol serverの開始

    # systemctl enable hatohol
    # systemctl start hatohol

### Hatohol Webの開始

    # systemctl enable httpd
    # systemctl start httpd

Webブラウザを使ったアクセス
--------------------------
### SELinuxとfirewallの設定確認
デフォルトでは、SELinuxやfirewallのようないくつかのセキュリティ機構によって他のコンピュータからのアクセスが妨げられます。
必要に応じてそれらを解除しなければなりません。

【警告】下記の設定を行うにあたり、セキュリティリスクについてよく理解してください。

現在のSELinuxの状態は次のコマンドで確認できます。

    # getenforce
    Enforcing

もし'Enforcing'であれば、次のコマンドでSELinuxポリシールールの強制を解除できます。

    # setenforce 0
    # getenforce
    Permissive

【ヒント】/etc/selinux/configを編集することで、恒久的な無効化を行えます。

firewallについては、以下のコマンドを実行することで許可ポートを追加できます。
以下の例は80番ポートを許可する例です。

    # firewall-cmd --zone=public --add-port=80/tcp --permanent
    # firewall-cmd --zone=public --add-port=80/tcp

### Hatohol情報の閲覧
例えば、Hatohol clientが192.168.1.1で動作している場合、
ブラウザを用いて次のURLを開いてください。

- http://192.168.1.1/hatohol

デフォルトのユーザ名： admin パスワード： hatohol でログインすることで、
各種画面の閲覧が可能になります。

【メモ】
現在、上記ページは、Google ChromeおよびFirefoxを使ってチェックされています。  
Internet Explorerを使用する場合、ご使用のバージョンによっては表示レイアウトが崩れる場合があります。
