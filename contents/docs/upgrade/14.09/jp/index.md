entOS 6.5 (x86_64)での14.03から14.06へのyumを用いたアップグレード方法
=====================================================================

Hatoholのアップデート方法
-------------------------------
### Hatohol Serverの停止
アップデートするためにHatohol Serverを停止させます。

以下のコマンドでHatohol Serverを停止させてください。

    # service hatohol stop

### アップデート方法
以下のコマンドでアップデートしてください。

    # yum upgrade hatohol hatohol-client

### Hatohol Serverの開始
以下のコマンド

    # service hatohol start
    # service httpd start

Hatohol serverが正常に開始した場合、以下のようなメッセージが表示されます。

    Starting hatohol: [INFO] <ConfigManager.cc:429> Use configuration file: /etc/hatohol/hatohol.conf
    [INFO] <main.cc:171> started hatohol server: ver. 14.09

### Hatohol情報の閲覧
例えば、Hatohol clientが192.168.1.1で動作している場合、
ブラウザを用いて次のURLを開いてください。

- http://192.168.1.1/

【メモ】  
現在、上記ページは、Google ChromeおよびFirefoxを使ってチェックされています。
Internet Explorerを使用する場合は、ご使用のバージョンによっては、
表示レイアウトが崩れる場合があります。（IE11では正常に表示されることを確認しています）

注意
---
### hatohol-config-db-creatorコマンドは廃止されました
HatoholのDBを初期化するためのhatohol-config-db-creatorコマンドを削除しました。  
しかし、その代わりにhatohol-db-initiatorコマンドを追加しました。  
そして、監視サーバ情報やインシデント管理サーバ情報の登録はhatohol-db-initiatorコマンドによって追加することが不可能になりました。  
それらの情報を登録するにはWEBインターフェースを利用して下さい。

使用方法:

    $ hatohol-db-initiator hatohol <User name of MySQL root user> <Password of MySQL root user>

情報:  
もし、以下のエラーが発生した場合、

    ImportError: No module named argparse

以下のコマンドを実行して必要なパッケージをインストールしてください。

    # yum install python-argparse

TIPS:

- もしMySQLのrootパスワードが指定されていない場合、""を利用してください。
- 生成されるDBのユーザ名とパスワードを--hatohol-db-userと--hatohol-db-passwordオプションを利用して変更することができます。
    - その時は/etc/hatohol/hatohol.confファイルを修正してください。

