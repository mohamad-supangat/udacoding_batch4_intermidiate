-- Adminer 4.7.7 MySQL dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

SET NAMES utf8mb4;

DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1,	'2014_10_12_000000_create_users_table',	1),
(2,	'2014_10_12_100000_create_password_resets_table',	1),
(3,	'2016_06_01_000001_create_oauth_auth_codes_table',	1),
(4,	'2016_06_01_000002_create_oauth_access_tokens_table',	1),
(5,	'2016_06_01_000003_create_oauth_refresh_tokens_table',	1),
(6,	'2016_06_01_000004_create_oauth_clients_table',	1),
(7,	'2016_06_01_000005_create_oauth_personal_access_clients_table',	1),
(8,	'2019_08_19_000000_create_failed_jobs_table',	1),
(9,	'2021_02_13_132659_create_video_favorites_table',	1);

DROP TABLE IF EXISTS `oauth_access_tokens`;
CREATE TABLE `oauth_access_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `client_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_access_tokens_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `oauth_access_tokens` (`id`, `user_id`, `client_id`, `name`, `scopes`, `revoked`, `created_at`, `updated_at`, `expires_at`) VALUES
('55139a0da4bb158f7b34a2ff0b9159c21284a7e76b0a728c265f3df54637fe6e2c0c306338bd863a',	2,	1,	'authToken',	'[]',	1,	'2021-02-15 03:25:55',	'2021-02-15 03:25:55',	'2022-02-15 03:25:55'),
('a39b3b893cf2e3ac2e887feeef5ec2da5d550006243a55f9e88c49f51dcac9f6e2b677132cfccd55',	1,	1,	'authToken',	'[]',	1,	'2021-02-15 03:23:54',	'2021-02-15 03:23:54',	'2022-02-15 03:23:54');

DROP TABLE IF EXISTS `oauth_auth_codes`;
CREATE TABLE `oauth_auth_codes` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `client_id` bigint(20) unsigned NOT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_auth_codes_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `oauth_clients`;
CREATE TABLE `oauth_clients` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `provider` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `redirect` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_clients_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `oauth_clients` (`id`, `user_id`, `name`, `secret`, `provider`, `redirect`, `personal_access_client`, `password_client`, `revoked`, `created_at`, `updated_at`) VALUES
(1,	NULL,	'Laravel Personal Access Client',	'9RkDKxssOkWBD86EeAQMtOl2Mbrrw3GerPVtwmiv',	NULL,	'http://localhost',	1,	0,	0,	'2021-02-15 03:22:12',	'2021-02-15 03:22:12'),
(2,	NULL,	'Laravel Password Grant Client',	'1Hq9F1KAHNIYyVwQHJtfUCXTnC20WXTCgstdYYTy',	'users',	'http://localhost',	0,	1,	0,	'2021-02-15 03:22:12',	'2021-02-15 03:22:12');

DROP TABLE IF EXISTS `oauth_personal_access_clients`;
CREATE TABLE `oauth_personal_access_clients` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `client_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `oauth_personal_access_clients` (`id`, `client_id`, `created_at`, `updated_at`) VALUES
(1,	1,	'2021-02-15 03:22:12',	'2021-02-15 03:22:12');

DROP TABLE IF EXISTS `oauth_refresh_tokens`;
CREATE TABLE `oauth_refresh_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1,	'Mohamad Supangat',	'admin@gmail.com',	NULL,	'$2y$10$tAwVU5N0IDoHpO1busy9BuiZDMkz9aVtKwJ47.WwaOrToRptwbA9y',	'K72X5dTRic5hgpMSoCZRyuVV9Dub6a69v4tu2pH8NIgsbSgsngclgI6ocIiz',	'2021-02-15 03:23:44',	'2021-02-15 03:23:44'),
(2,	'supangat',	'supangat@gmail.com',	NULL,	'$2y$10$hFwW1kTed7ZTiXhmCuYMlebJwUrWtKTc2Sk8CfG1aoYZM9VcDBQYW',	'j1rjLAr5PQo4xmOgOxqQk2GABgDkGrWqRKkrF1vFqQCifmcUKlfACAol2aqP',	'2021-02-15 03:25:45',	'2021-02-15 03:25:45');

DROP TABLE IF EXISTS `video_favorites`;
CREATE TABLE `video_favorites` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `thumbnail_url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tags` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`tags`)),
  `user_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `video_favorites_user_id_foreign` (`user_id`),
  CONSTRAINT `video_favorites_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `video_favorites` (`id`, `title`, `description`, `thumbnail_url`, `tags`, `user_id`, `created_at`, `updated_at`) VALUES
('KTx3qJP8Nds',	'BLOGGER KAYA vs MISKIN || Prank Lucu dan Trik di Youtube oleh RATATA BOOM',	'Berlangganan ke saluran RATATA BOOM! Indonesian\nhttps://www.youtube.com/channel/UCyNjDKW9XGAsUdmv21KDwFA?sub_confirmation=1\nGadis DINGIN KAYA vs Gadis PANAS MISKIN: https://youtu.be/8rzni5tHDsc\n\nKalian memiliki impian menjadi blogger sejak lama, tapi ketika kalian melihat blogger-blogger yang sangat populer dan kaya, kalian menjadi sedih karena video-video mereka berkualitas sangat tinggi dan kalian paham kalian tak punya uang. Jangan khawatir, hidupkanlah imajinasimu, karena kadang, untuk menjadi populer, kalian hanya perlu ide-ide menarik yang akan disukai orang lain.\n \nBagikan video ini dengan temanmu dan jangan lupa subscribe ke saluran RATATA!\n \n Music by Epidemic Sound: https://www.epidemicsound.com/\n \n#RatataBoom #Lucu #Kaya',	'https://i.ytimg.com/vi/KTx3qJP8Nds/mqdefault.jpg',	'[\"Kaya\",\"miskin\",\"bangkrut\",\"kaya vs miskin\"]',	1,	'2021-02-15 03:24:56',	'2021-02-15 03:24:56');

-- 2021-02-15 03:38:53
