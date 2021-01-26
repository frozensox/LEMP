# LEMP
Laravel 用の LEMP(nginx+MySQL+PHP) 環境を Docker で構築します。

## ディレクトリ構成
```
├─ README.md
├─ docker-compose.yml
├─ .env.example
├─ .env # コンテナのビルドに使用する環境変数を設定
│
├── conf
│    ├─ nginx.conf # nginx 設定ファイル
│    ├─ mysql.cnf # MySQL 設定ファイル
│    └─ php.ini # PHP 設定ファイル
│
├── docker
│    │
│    ├── app
│    │    └─ Dockerfile
│    │
│    └── db
│         └─ Dockerfile
│
└── laravel # Laravel プロジェクト作成先（.env で変更可）
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
$ docker-compose exec app composer create-project --prefer-dist laravel/laravel .
```
5. .envファイルを作成
```
$ docker-compose exec app cp .env.example .env
```
6. アプリケーションキーを生成
```
$ docker-compose exec app php artisan key:generate
```
7. マイグレーションの実行を確認
```
$ docker-compose exec app php artisan migrate
```
ブラウザから http://localhost:8080/ にアクセスしLaravelのWelcome画面が表示されることを確認

## MySQLへの接続
```
$ docker-compose exec db bash -c 'mysql -u root -p${MYSQL_ROOT_PASSWORD} -D ${MYSQL_DATABASE}'
mysql> SHOW TABLES;
```

## 参考記事
- [【超入門】20分でLaravel開発環境を爆速構築するDockerハンズオン](https://qiita.com/ucan-lab/items/56c9dc3cf2e6762672f4)
- [Dockerを使ってLaravelのローカル開発環境を作る(Apache版)](https://qiita.com/ucan-lab/items/38cd04cee1f3f9e024b9)
