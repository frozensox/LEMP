# LEMP
Laravel 用の LEMP(nginx+MySQL+PHP) 環境を Docker で構築します。

## ディレクトリ構成
```
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
4. Laravelをインストール
```
$ docker-compose exec web composer create-project --prefer-dist laravel/laravel .
```
5. .envファイルを作成
```
$ docker-compose exec web cp .env.example .env
```
6. アプリケーションキーを生成
```
$ docker-compose exec web php artisan key:generate
```
7. マイグレーションの実行を確認
```
$ docker-compose exec web php artisan migrate
```
ブラウザから http://localhost:8080/ にアクセスしLaravelのWelcome画面が表示されることを確認

## MySQLへの接続
```
$ docker-compose exec db bash -c 'mysql -u root -p${MYSQL_ROOT_PASSWORD} -D ${MYSQL_DATABASE}'
mysql> SHOW TABLES;
```
