#!/bin/bash

error_log() {
  echo ''
  echo $1
  exit 1
}

cp .env.example .env &&
(docker-compose up -d --build || error_log 'Failed to build container.') &&
(docker-compose exec app composer create-project --prefer-dist laravel/laravel . || error_log 'Failed to install Laravel.') &&
(docker-compose exec app php artisan migrate || error_log 'Failed to migrate in Laravel.') &&
echo '' &&
echo 'Installation was successful.'
