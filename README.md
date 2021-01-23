# LEMP
Laravel用のLEMP(PHP+nginx+MySQL)環境をDockerで構築します。
## ディレクトリ構造
```
.
├─ README.md
├─ docker-compose.yml
│
├── container
│    │
│    ├── php
│    │    ├─ Dockerfile
│    │    └─ php.ini # PHPの設定ファイル
│    │
│    ├── nginx
│    │    └─ default.conf # サーバ設定ファイル
│    │
│    └── mysql
│         ├─ Dockerfile
│         └─ my.cnf # MySQLの設定ファイル
│
└── laravel # Laravelのインストール先
```

## 環境の再現手順
1. GitHubからリポジトリをクローン
```
$ git clone https://github.com/frozensox/LEMP.git
```
2. .gitディレクトリを削除（Gitはダウンロードするためだけに使用します）
```
$ cd LEMP
rm -rf .git
```
3. コンテナをビルド
```
$ docker-compose up -d --build
```
4. appコンテナに接続
```
$ docker-compose exec app bash
```
5. プロジェクトフォルダを作成（省略可）
```
# mkdir [プロジェクト名] && cd $_
```
6. Laravelをインストール
```
# composer install
```
7. .envファイルを作成
```
# cp .env.example .env
```
8. アプリケーションキーを生成
```
# php artisan key:generate
```
9. マイグレーションの実行を確認
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
    build: ./container/mysql
    volumes:
      - db-store:/var/lib/mysql
volumes:
  db-store:
```
