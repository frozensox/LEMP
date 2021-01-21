# LEMP
Laravel用のLEMP(PHP+nginx+MySQL)環境をDockerで構築します。
## ディレクトリ構造
.
├─ lib
│ └─ php
│   ├─ Dockerfile
│   └─ php.ini # PHPの設定ファイル
│ └─ nginx
│   └─ default.conf # サーバ設定ファイル
│ └─ mysql
│   ├─ Dockerfile
│   └─ my.cnf # MySQLの設定ファイル
├─ project # Laravelインストール済み
└─ docker-compose.yml

## MySQLコンテナに関する注意点
docker-compose.ymlでMySQLコンテナを追加する際、Docker上のMySQLディレクトリにホスト上のディレクトリをマウントするようにVolumesを設定すると、環境によってコンテナが立ち上がらないことがあります。
ホストにあるディレクトリをマウントするのではなく、名前付きボリュームを指定します。
docker-compose.yml:
>  db:
>    build: ./lib/mysql
>    volumes:
>      - db-store:/var/lib/mysql
>volumes:
>  db-store:
