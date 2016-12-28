Hatohol Arm Pluginの使い方
=======================
※このドキュメントは2016/12/26現在の情報を元に記載されています

CentOS7へのHatohol Arm Plugin（以下HAP）インストール、設定方法。

このドキュメントはHatoholサーバー、RabbitMQサーバー、HAPを同一ホスト上で動かすケースを基本として記述してあります。
Hatoholは、Hatoholサーバー、HAP、RabbitMQサーバー、MariaDBをそれぞれ異なるサーバーで動かす構成も可能であるため、一部、またはすべてを個別のホストで動かす場合には別途設定が必要なケースがあります。  
可能なサーバー、モジュール構成は次のURLを参照してください。  
[サーバー、モジュール構成](https://github.com/project-hatohol/hatohol/wiki/%E3%82%B5%E3%83%BC%E3%83%90%E3%83%BC%E3%80%81%E3%83%A2%E3%82%B8%E3%83%A5%E3%83%BC%E3%83%AB%E6%A7%8B%E6%88%90)

設置済みのRabbitMQサーバーを使う場合、[RabbitMQサーバーの設定](#RabbitMQサーバーの設定)から参照してください。

* [RabbitMQサーバーのインストールと起動](#RabbitMQサーバーのインストールと起動)
* [RabbitMQサーバーの設定](#RabbitMQサーバーの設定)
* [HAPと依存モジュールのインストール](#HAPと依存モジュールのインストール)
* [HAPの設定(WebUIメニューのサーバータイプに表示させる手順)](#HAPの設定(WebUIメニューのサーバータイプに表示させる手順))
* [HAPの設定(Hatoholサーバーと別ホストに設置した場合のconf設定)](#HAPの設定(Hatoholサーバーと別ホストに設置した場合のconf設定))

---

## RabbitMQサーバーのインストールと起動


### インストール

EPELを使用してRabbitMQサーバーをインストールします。

以下のコマンドを実行し、EPELレポジトリの登録をしてください。  
すでに登録済みの場合は不要です。

    # yum install epel-release

以下のコマンドでEPELリポジトリからrabbitmq-serverをインストールしてください。

    # yum install rabbitmq-server


### rabbitmq-serverの起動

以下のコマンドでrabbitmq-serverを有効にして起動してください。

    # systemctl enable rabbitmq-server
    # systemctl start rabbitmq-server


### SELinuxとfirewallの設定確認

デフォルトでは、SELinuxやfirewallのようないくつかのセキュリティ機構によって他のコンピュータからのアクセスが妨げられます。 必要に応じてそれらを解除しなければなりません。

firewalldで5672/tcpポートを許可し、SELinuxを無効にする必要があります。

**【警告】 下記の設定を行うにあたり、セキュリティリスクについてよく理解してください。**

firewallについては、以下のコマンドを実行することで許可ポートを追加できます。 以下の例は5672番ポートを許可する例です。  
TLS接続を使用する場合デフォルトでは5671番ポートが使われます。必要に応じて許可してください。

    # firewall-cmd --add-port=5672/tcp --zone=public --permanent
    # firewall-cmd --add-port=5672/tcp --zone=public

次のコマンドでSELinuxを無効にする必要があります。

    # setsebool -P nis_enabled 1


---

## RabbitMQサーバーの設定

RabbitMQにHatoholで使用する仮想ホスト、ユーザーID、パスワードの設定を行います。  
このドキュメントでは、仮想ホスト名は `hatohol`、ユーザーIDとパスワードも` hatohol`と仮定しています。  

最初に、仮想ホストを作成します。

    $ rabbitmqctl add_vhost hatohol

次に、ユーザーIDとパスワードを作成します。

    $ rabbitmqctl add_user hatohol hatohol

最後に、作成したユーザーIDに仮想ホストへの権限を設定します。

    $ rabbitmqctl set_permissions -p hatohol hatohol ".*" ".*" ".*"

---

## HAPと依存モジュールのインストール

次のコマンドを実行し、EPELレポジトリの登録をしてください。  
（python2-pikaの依存関係解決に必要です。）  
すでに追加されている場合にはこの手順は不要です。

    # yum install epel-release

### Project Hatohol公式yumレポジトリの登録
Hatoholサーバーをインストールしたホストと異なるホストにインストールする場合、以下のコマンドを実行し、Project Hatohol公式が提供するyumレポジトリの登録をしてください。  
すでに追加されている場合にはこの手順は不要です。

    # wget -P /etc/yum.repos.d/ http://project-hatohol.github.io/repo/hatohol-el7.repo

### HAPのインストール

次のコマンドを使用してhatohol-hap2-*をインストールします。  
（ここでは主にhatohol-hap2-zabbixに関して説明します。）

    # yum install hatohol-hap2-zabbix

hap2-nagios-livestatusをインストールする場合、 `python-mk-livestatus`モジュールをインストールする必要があります。
以下のコマンドを実行します。

    # pip install python-mk-livestatus

---

## HAPの設定(WebUIメニューのサーバータイプに表示させる手順)

HAPインストール後は、Hatohol WebUIでHAPを選択できるように設定する必要があります。

各HAPのRPMは/usr/share/hatohol/sql/に拡張子.sqlのファイルをインストールします。
それぞれのファイルとhatohol-db-initiatorコマンドで監視サーバーの種類を追加し、WebUIから使用できるよう設定します。
次のコマンドを実行してください。

    $ hatohol-db-initiator --db-user <YOUR_DB_USER> --db-password <YOUR_DB_PASSWORD>

※複数回実行しても影響はありません。

コマンドを実行するのはHatoholサーバーをインストールしたホストになります。次のケースでは上記のコマンドを実行するとエラーになることがあるため、別途手順が必要です。

1. HAPのみをインストールしたホストで実行した場合
コマンドがインストールされていないため、実行できません。次のいずれかの手順で対応ください。
	1. /usr/share/hatohol/sql/に存在する*.sqlファイルを、Hatoholサーバーをインストールしたホストの同一ディレクトリにコピーしてからhatohol-db-initiatorコマンドを実行する。
	1. HatoholサーバーをインストールしたホストにHAPもインストールする  
	この場合、hatohol-db-initiatorコマンド実行後にHAPをアンインストールして問題ありません。

1. DBサーバーがHatoholサーバーと異なるホストにある場合や、ポート番号がデフォルトとは異なるポートの場合
	1. hatohol-db-initiatorコマンドに、次のオプションを付与して実行してください。  
	--host <ホスト名またはIPアドレス>  
	--port <ポート番号>

実行後、hatohol-db-initiatorコマンドの出力に次の文字列があるか確認してください。

    Succeessfully loaded: /usr/bin/../share/hatohol/sql/90-server-type-hap2-zabbix.sql

---

## HAPの設定(パッシブ: Hatoholサーバーと別ホストに設置した場合のconf設定)

HAPをHatoholサーバーと別のホストに設置した場合には/etc/hatohol/hap2.confファイルへの設定が必要です。  
（同一ホストに設置した場合にはHatoholがHAPを起動するため設定は不要）

次の6箇所は修正を検討してください。

    [hap2]
    amqp_broker = localhost ...1
    #amqp_port = 5672 ...2
    #amqp_vhost = hatohol ...3
    amqp_queue = q01 ...4
    amqp_user = hatohol ...5
    amqp_password = hatohol ...6

1. RabbitMQをインストールしたホスト名、またはIPアドレス
1. RabbitMQが待ち受けしているポート番号（デフォルトから変更がある場合）
1. RabbitMQで設定した仮想ホスト名（※必ずコメントを外してください）
1. Hatohol WebUIで設定する静的キューアドレス（ここで設定した文字列をWebUIの静的キューアドレスにも設定してください）
1. RabbitMQで設定した仮想ホスト名に対するユーザ名（hatoholと異なるidを付与した場合）
1. RabbitMQで設定したユーザ名に対するパスワード（hatoholと異なるpwを付与した場合）

