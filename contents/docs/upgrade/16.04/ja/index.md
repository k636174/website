CentOS 7 (x86_64) での16.01から16.04へのアップグレードについて
========================================================================

## ***16.04は以前のバージョンからのアップグレードには対応していません。***

もし過去バージョンのデータを保管しておきたい場合は以下の方法でバックアップを取得し，データベースの名前を変更してインポートしてください。またはインポートせずバックアップのまま保管してください。

## ArmXXXの削除

今回のリリースで，Hatoholサーバー内部の組み込みのデータ取得法が削除されました。

これからはHatohol Arm Plugin2を使用し，データを取得してください。

## バックアップ取得方法

    $ mysqldump -u [MySQL のルートユーザー名] -p [MySQLのルートパスワード] [旧データベース名] > hatohol.sql

## バックアップから別名でデータベースをインポートする方法

    $ mysql -u [MySQL のルートユーザー名] -p [MySQLのルートパスワード] [New database name] < hatohol.sql
