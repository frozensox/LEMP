# LEMP
Laravel用のLEMP(PHP+nginx+MySQL)環境をDockerで構築します。
## ディレクトリ構造
```
.
├─ README.md
├── lib
├─ docker-compose.yml
│    ├── php
│    │   ├─ Dockerfile
│    │   └─ php.ini # PHPの設定ファイル
│    ├── nginx
│    │   └─ default.conf # サーバ設定ファイル
│    └── mysql
│       ├─ Dockerfile
│       └─ my.cnf # MySQLの設定ファイル
└── project # Laravelのインストール先
```

## 環境の再現手順
1. GitHubからリポジトリをクローン
```
$ git clone https://github.com/frozensox/LEMP.git
```
2. コンテナをビルド
```
$ cd LEMP
$ docker-compose up -d --build
```
3. appコンテナに接続
```
$ docker-compose exec app bash
```
4. Laravelをインストール
```
# composer install
```
5. .envファイルを作成
```
# cp .env.example .env
```
6. アプリケーションキーを生成
```
# php artisan key:generate
```
7. マイグレーションの実行を確認
```
# php artisan migrate
```
ブラウザから http://localhost:8080/ にアクセスしLaravelのWelcome画面が表示されることを確認

## MySQLへの接続
```
$ docker-compose exec db bash -c 'mysql -u root -p${MYSQL_ROOT_PASSWORD} -D ${MYSQL_DATABASE}'
mysql> SHOW TABLES;
```

## MySQLコンテナに関する注意点
docker-compose.ymlでMySQLコンテナを追加する際、Docker上のMySQLディレクトリにホスト上のディレクトリをマウントするようにVolumesを設定すると、環境によってコンテナが立ち上がらないことがあります。
ホストにあるディレクトリをマウントするのではなく、名前付きボリュームを指定します。  
  
docker-compose.yml:
```
  db:
    build: ./lib/mysql
    volumes:
      - db-store:/var/lib/mysql
volumes:
  db-store:
```
