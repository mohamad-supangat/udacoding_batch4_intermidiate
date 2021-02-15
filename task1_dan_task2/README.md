# Aplikasi Task 1 dan 2 Batch 4 intermediate

## Aplikasi flutter / client

- untuk aplikasi flutter ada di folder `flutter`
- Pengaturana config ada di `lib/config.dart`

## Aplikasi laravel / sebagai server

source code ada di folder `laravel`

file import database ada di file `db.sql`

### requirement

- php 7.4 / paling terbaru
- package composer https://getcomposer.org/

### instalasi

1. buka folder `api`
2. jalankan perintah `composer install` untuk mendownload package yang diperlukan
3. import file import database yang tertera di atas
4. Ubah configurasi yang terdapat di file `.env`
5. Lakukan installasi key untuk passport token `php artisan passport:install --force`

6. Jalankan server laravel dengan perintah `php artisan serve`

## NOTE

- wajib install key untuk passport agar auth token berjalan

Copyright 2021 Mohamad Supangat
