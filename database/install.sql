-- Anitium clean installation schema
-- Generated at 2026-07-02T20:51:07.929Z
-- This file creates tables and base seed data. The web setup writes the first admin.

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS=0;

DROP TABLE IF EXISTS `admin_audit_logs`;
CREATE TABLE `admin_audit_logs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned DEFAULT NULL,
  `method` varchar(10) NOT NULL,
  `path` varchar(255) NOT NULL,
  `action` varchar(120) NOT NULL,
  `target_id` varchar(120) DEFAULT NULL,
  `status_code` smallint unsigned DEFAULT NULL,
  `ip` varchar(64) DEFAULT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `metadata` json DEFAULT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_admin_audit_user` (`user_id`,`created_at`),
  KEY `idx_admin_audit_path` (`path`,`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

DROP TABLE IF EXISTS `admin_idempotency_keys`;
CREATE TABLE `admin_idempotency_keys` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(160) COLLATE utf8mb4_general_ci NOT NULL,
  `method` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `path` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `user_id` int unsigned DEFAULT NULL,
  `request_hash` char(64) COLLATE utf8mb4_general_ci NOT NULL,
  `status_code` smallint unsigned DEFAULT NULL,
  `response_json` json DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `expires_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_admin_idempotency_key` (`key`),
  KEY `idx_admin_idempotency_expires` (`expires_at`),
  KEY `idx_admin_idempotency_user` (`user_id`,`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `admin_update_logs`;
CREATE TABLE `admin_update_logs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned DEFAULT NULL,
  `version` varchar(80) DEFAULT NULL,
  `package_name` varchar(160) DEFAULT NULL,
  `status` varchar(30) NOT NULL,
  `message` varchar(255) DEFAULT NULL,
  `files_changed` int unsigned NOT NULL DEFAULT '0',
  `backup_dir` varchar(255) DEFAULT NULL,
  `metadata` json DEFAULT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_admin_update_created` (`created_at`),
  KEY `idx_admin_update_status` (`status`,`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

DROP TABLE IF EXISTS `anime`;
CREATE TABLE `anime` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mal_id` int NOT NULL,
  `anilist_id` int NOT NULL,
  `title` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `title_english` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `title_japanese` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `title_synonyms` varchar(555) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `is_hidden` tinyint(1) NOT NULL DEFAULT '0',
  `raw` smallint NOT NULL DEFAULT '0',
  `sub` smallint NOT NULL DEFAULT '0',
  `dub` smallint NOT NULL DEFAULT '0',
  `images` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `country` tinyint(1) NOT NULL DEFAULT '1',
  `quality` tinyint(1) NOT NULL DEFAULT '2',
  `episodes` int NOT NULL,
  `type` int NOT NULL,
  `source` int NOT NULL,
  `status` int NOT NULL,
  `airing` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `aired` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `aired_from` date DEFAULT NULL,
  `aired_to` date DEFAULT NULL,
  `duration` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `rating` int NOT NULL,
  `score` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `season` int NOT NULL,
  `year` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `synopsis` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `promo` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `mal_id` (`mal_id`),
  KEY `idx_anime_public_filter` (`is_hidden`,`rating`,`status`,`year`,`id`),
  KEY `idx_anime_upcoming` (`is_hidden`,`status`,`rating`,`aired_from`,`id`),
  KEY `idx_anime_visibility_trending` (`is_hidden`,`deleted_at`,`status`,`rating`,`updated_at`,`id`),
  FULLTEXT KEY `anime_search_fulltext` (`title`,`title_english`,`title_japanese`,`title_synonyms`,`synopsis`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `anime_comment_votes`;
CREATE TABLE `anime_comment_votes` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `comment_id` int unsigned NOT NULL,
  `user_id` int unsigned NOT NULL,
  `type` tinyint NOT NULL DEFAULT '1',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `anime_comment_votes_unique` (`comment_id`,`user_id`),
  KEY `idx_anime_comment_votes_comment_type` (`comment_id`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `anime_comments`;
CREATE TABLE `anime_comments` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `target_type` enum('anime_detail','anime_episode') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'anime_episode',
  `anime_id` int unsigned NOT NULL,
  `episode_id` int unsigned DEFAULT NULL,
  `user_id` int unsigned NOT NULL,
  `mention_id` int unsigned DEFAULT NULL,
  `parent_id` int unsigned DEFAULT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `is_pinned` tinyint(1) NOT NULL DEFAULT '0',
  `is_spoil` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_anime_comments_parent` (`parent_id`,`deleted_at`,`created_at`,`id`),
  KEY `idx_anime_comments_page` (`anime_id`,`target_type`,`episode_id`,`parent_id`,`deleted_at`,`is_pinned`,`created_at`,`id`),
  KEY `idx_anime_comments_user` (`user_id`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `anime_episode_embeds`;
CREATE TABLE `anime_episode_embeds` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `episode_id` int NOT NULL,
  `embed_type` int NOT NULL,
  `embed_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `embed_order` int NOT NULL,
  `embed_frame` varchar(650) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `group_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Default',
  `group_translator` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_anime_episode_embeds_episode` (`episode_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `anime_episodes`;
CREATE TABLE `anime_episodes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `anime_id` int NOT NULL,
  `premium` tinyint(1) NOT NULL DEFAULT '0',
  `xec` tinyint NOT NULL,
  `episode_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `raw` tinyint(1) NOT NULL,
  `sub` tinyint(1) NOT NULL,
  `dub` tinyint(1) NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `title_romanji` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `filler` int NOT NULL,
  `recap` int NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_anime_episodes_anime_created` (`anime_id`,`created_at`,`id`),
  KEY `idx_anime_episodes_anime_ep` (`anime_id`,`episode_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `anime_genre_catalog`;
CREATE TABLE `anime_genre_catalog` (
  `id` int NOT NULL AUTO_INCREMENT,
  `genre` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `anime_genre_catalog_genre_unique` (`genre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `anime_genres`;
CREATE TABLE `anime_genres` (
  `anime_id` int NOT NULL,
  `genre_id` int NOT NULL,
  PRIMARY KEY (`anime_id`,`genre_id`),
  KEY `genre_id` (`genre_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `anime_producer_catalog`;
CREATE TABLE `anime_producer_catalog` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `anime_producers`;
CREATE TABLE `anime_producers` (
  `anime_id` int unsigned NOT NULL,
  `producer_id` int unsigned NOT NULL,
  PRIMARY KEY (`anime_id`,`producer_id`),
  KEY `producer_id` (`producer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `anime_relations`;
CREATE TABLE `anime_relations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `relation_group` int NOT NULL,
  `relation_order` tinyint NOT NULL,
  `anime_id` int NOT NULL,
  `relation_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_anime_relations_anime` (`anime_id`),
  KEY `idx_anime_relations_group` (`relation_group`,`relation_order`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `anime_schedule`;
CREATE TABLE `anime_schedule` (
  `id` int NOT NULL AUTO_INCREMENT,
  `anime_id` int unsigned NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `episodes` json NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `anime_schedule_anime_id_unique` (`anime_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `anime_slider`;
CREATE TABLE `anime_slider` (
  `id` int NOT NULL AUTO_INCREMENT,
  `anime_id` int unsigned NOT NULL,
  `backdrop_image` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `mal_id` (`anime_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `anime_studio_catalog`;
CREATE TABLE `anime_studio_catalog` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `anime_studios`;
CREATE TABLE `anime_studios` (
  `anime_id` int unsigned NOT NULL,
  `studio_id` int unsigned NOT NULL,
  PRIMARY KEY (`anime_id`,`studio_id`),
  KEY `studio_id` (`studio_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `anime_view_stats`;
CREATE TABLE `anime_view_stats` (
  `anime_id` int unsigned NOT NULL,
  `views_total` int unsigned NOT NULL DEFAULT '0',
  `views_daily` int unsigned NOT NULL DEFAULT '0',
  `views_weekly` int unsigned NOT NULL DEFAULT '0',
  `views_monthly` int unsigned NOT NULL DEFAULT '0',
  `last_viewed_at` datetime DEFAULT NULL,
  `daily_reset_at` datetime DEFAULT NULL,
  `weekly_reset_at` datetime DEFAULT NULL,
  `monthly_reset_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`anime_id`),
  KEY `idx_anime_view_stats_daily` (`views_daily`,`anime_id`),
  KEY `idx_anime_view_stats_weekly` (`views_weekly`,`anime_id`),
  KEY `idx_anime_view_stats_monthly` (`views_monthly`,`anime_id`),
  KEY `idx_anime_view_stats_total` (`views_total`,`anime_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `anime_views`;
CREATE TABLE `anime_views` (
  `id` int NOT NULL AUTO_INCREMENT,
  `anime_id` int unsigned NOT NULL DEFAULT '0',
  `episode_id` int unsigned DEFAULT NULL,
  `user_id` int unsigned DEFAULT NULL,
  `session_key` varchar(120) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `ip_hash` varchar(80) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `user_agent_hash` varchar(80) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `watched_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `mal_id` (`anime_id`),
  KEY `idx_anime_views_anime_date` (`anime_id`,`watched_at`),
  KEY `idx_anime_views_episode_date` (`episode_id`,`watched_at`),
  KEY `idx_anime_views_user_date` (`user_id`,`watched_at`),
  KEY `idx_anime_views_session_date` (`session_key`,`watched_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `anime_votes`;
CREATE TABLE `anime_votes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `anime_id` int NOT NULL,
  `user_id` int NOT NULL,
  `vote` int NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `anime_vote_user_anime_unique` (`user_id`,`anime_id`),
  KEY `idx_anime_votes_anime_deleted` (`anime_id`,`deleted_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `community_categories`;
CREATE TABLE `community_categories` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `slug` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `icon` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'message-circle',
  `tone` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'sky',
  `staff_only` tinyint(1) NOT NULL DEFAULT '0',
  `sort_order` int NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `community_comment_votes`;
CREATE TABLE `community_comment_votes` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `comment_id` int unsigned NOT NULL,
  `user_id` int unsigned NOT NULL,
  `type` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `comment_id_user_id` (`comment_id`,`user_id`),
  KEY `idx_comment_votes_comment_type` (`comment_id`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `community_comments`;
CREATE TABLE `community_comments` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `topic_id` int unsigned DEFAULT NULL,
  `user_id` int unsigned NOT NULL,
  `mention_id` int unsigned DEFAULT NULL,
  `parent_id` int unsigned DEFAULT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `is_pinned` tinyint(1) NOT NULL DEFAULT '0',
  `is_spoil` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `topic_id_parent_id` (`topic_id`,`parent_id`),
  KEY `idx_community_comments_cursor` (`topic_id`,`parent_id`,`deleted_at`,`is_pinned`,`created_at`,`id`),
  KEY `idx_community_comments_parent_cursor` (`parent_id`,`deleted_at`,`created_at`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `community_group_activity`;
CREATE TABLE `community_group_activity` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `group_id` int unsigned NOT NULL,
  `actor_id` int unsigned DEFAULT NULL,
  `target_user_id` int unsigned DEFAULT NULL,
  `activity_type` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `metadata` json DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_group_activity_group` (`group_id`,`created_at`),
  KEY `idx_group_activity_actor` (`actor_id`),
  KEY `idx_group_activity_target` (`target_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `community_group_donations`;
CREATE TABLE `community_group_donations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `group_id` int unsigned NOT NULL,
  `user_id` int unsigned NOT NULL,
  `amount` decimal(18,8) NOT NULL DEFAULT '0.00000000',
  `note` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_community_group_donations_group` (`group_id`,`id`),
  KEY `idx_community_group_donations_user` (`user_id`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `community_group_members`;
CREATE TABLE `community_group_members` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `group_id` int unsigned NOT NULL,
  `user_id` int unsigned NOT NULL,
  `role` varchar(64) COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'member',
  `status` enum('active','pending','blocked') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'active',
  `joined_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `community_group_members_unique` (`group_id`,`user_id`),
  KEY `idx_community_group_members_user` (`user_id`,`status`,`deleted_at`),
  KEY `idx_community_group_members_group` (`group_id`,`status`,`deleted_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `community_group_payouts`;
CREATE TABLE `community_group_payouts` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `group_id` int unsigned NOT NULL,
  `actor_id` int unsigned NOT NULL,
  `user_id` int unsigned NOT NULL,
  `amount` decimal(18,8) NOT NULL DEFAULT '0.00000000',
  `note` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_community_group_payouts_group` (`group_id`,`id`),
  KEY `idx_community_group_payouts_user` (`user_id`,`id`),
  KEY `idx_community_group_payouts_actor` (`actor_id`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `community_group_roles`;
CREATE TABLE `community_group_roles` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `group_id` int unsigned NOT NULL,
  `role_key` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `label` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `sort_order` int NOT NULL DEFAULT '100',
  `is_system` tinyint(1) NOT NULL DEFAULT '0',
  `can_manage_members` tinyint(1) NOT NULL DEFAULT '0',
  `can_manage_settings` tinyint(1) NOT NULL DEFAULT '0',
  `can_manage_roles` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `community_group_roles_unique` (`group_id`,`role_key`),
  KEY `idx_community_group_roles_group` (`group_id`,`deleted_at`,`sort_order`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `community_groups`;
CREATE TABLE `community_groups` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `owner_id` int unsigned DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `slug` varchar(180) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `website` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `banner` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `logo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `membership_open` tinyint(1) NOT NULL DEFAULT '1',
  `xec_balance` decimal(18,8) NOT NULL DEFAULT '0.00000000',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `community_groups_slug_unique` (`slug`),
  KEY `idx_community_groups_status` (`status`,`deleted_at`),
  KEY `idx_community_groups_owner` (`owner_id`,`deleted_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `community_topic_views`;
CREATE TABLE `community_topic_views` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `topic_id` int unsigned NOT NULL,
  `user_id` int unsigned DEFAULT NULL,
  `session_key` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `ip_hash` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `user_agent_hash` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `viewed_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_topic_views_topic_date` (`topic_id`,`viewed_at`),
  KEY `idx_topic_views_user_date` (`user_id`,`viewed_at`),
  KEY `idx_topic_views_session_date` (`session_key`,`viewed_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `community_topic_votes`;
CREATE TABLE `community_topic_votes` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `topic_id` int unsigned NOT NULL,
  `user_id` int unsigned NOT NULL,
  `type` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `topic_id_user_id` (`topic_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `community_topics`;
CREATE TABLE `community_topics` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int unsigned NOT NULL,
  `user_id` int unsigned NOT NULL,
  `title` varchar(180) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `slug` varchar(220) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `notify_on_comment` tinyint(1) NOT NULL DEFAULT '1',
  `is_pinned` tinyint(1) NOT NULL DEFAULT '0',
  `is_locked` tinyint(1) NOT NULL DEFAULT '0',
  `views` int unsigned NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`),
  KEY `category_id_created_at` (`category_id`,`created_at`),
  KEY `user_id_created_at` (`user_id`,`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `converter_rules`;
CREATE TABLE `converter_rules` (
  `id` int NOT NULL AUTO_INCREMENT,
  `rule_type` enum('embed','autoapi') NOT NULL,
  `rule_key` varchar(80) NOT NULL,
  `name` varchar(150) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `sort_order` int NOT NULL DEFAULT '0',
  `config` json NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_converter_rules_type_key` (`rule_type`,`rule_key`),
  KEY `idx_converter_rules_type_enabled` (`rule_type`,`enabled`,`deleted_at`,`sort_order`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

DROP TABLE IF EXISTS `group_permissions`;
CREATE TABLE `group_permissions` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `group_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `permission_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_group_permissions_unique` (`group_name`,`permission_key`),
  KEY `idx_group_permissions_group` (`group_name`),
  KEY `idx_group_permissions_permission` (`permission_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `notification_job_items`;
CREATE TABLE `notification_job_items` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `job_id` int unsigned NOT NULL,
  `type` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `identifier` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `status` enum('pending','processing','completed','failed') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'pending',
  `payload` json NOT NULL,
  `result` json DEFAULT NULL,
  `attempts` int unsigned NOT NULL DEFAULT '0',
  `last_error` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `locked_at` datetime DEFAULT NULL,
  `completed_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_notification_job_item_identifier` (`job_id`,`identifier`),
  KEY `idx_notification_job_items_job_status` (`job_id`,`status`,`id`),
  KEY `idx_notification_job_items_type_status` (`type`,`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `notification_job_logs`;
CREATE TABLE `notification_job_logs` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `job_id` int unsigned DEFAULT NULL,
  `job_type` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `status` enum('success','warning','error','info') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'info',
  `summary` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `metrics` json NOT NULL,
  `details` json DEFAULT NULL,
  `error` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_notification_job_logs_job` (`job_id`,`id`),
  KEY `idx_notification_job_logs_type_status` (`job_type`,`status`,`id`),
  KEY `idx_notification_job_logs_created` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `notification_jobs`;
CREATE TABLE `notification_jobs` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `status` enum('pending','scheduled','processing','completed','failed') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'pending',
  `payload` json NOT NULL,
  `cursor_id` int unsigned NOT NULL DEFAULT '0',
  `attempts` int unsigned NOT NULL DEFAULT '0',
  `processed_count` int unsigned NOT NULL DEFAULT '0',
  `last_error` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `locked_at` datetime DEFAULT NULL,
  `available_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `completed_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_notification_jobs_status_available` (`status`,`available_at`,`id`),
  KEY `idx_notification_jobs_type_status` (`type`,`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `permission_definitions`;
CREATE TABLE `permission_definitions` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `permission_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `label` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_permission_definitions_key` (`permission_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `player_configs`;
CREATE TABLE `player_configs` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `episode_id` int NOT NULL,
  `op_start` decimal(8,2) DEFAULT NULL,
  `op_end` decimal(8,2) DEFAULT NULL,
  `ed_start` decimal(8,2) DEFAULT NULL,
  `ed_end` decimal(8,2) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `episode_id` (`episode_id`),
  CONSTRAINT `player_configs_episode_id_foreign` FOREIGN KEY (`episode_id`) REFERENCES `anime_episodes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `player_resources`;
CREATE TABLE `player_resources` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `display_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `group_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Anitium Player',
  `episode_id` int NOT NULL,
  `embed_type` tinyint NOT NULL DEFAULT '2',
  `source_order` int NOT NULL DEFAULT '1',
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `source_type` enum('video','proxy') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'video',
  `format_type` enum('mp4') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'mp4',
  `audio_lang` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'ja',
  `resolutions` json DEFAULT NULL,
  `use_auto_proxy` tinyint(1) NOT NULL DEFAULT '0',
  `cors_mode` enum('direct','proxy') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'direct',
  `custom_referer` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `episode_id` (`episode_id`),
  CONSTRAINT `player_resources_episode_id_foreign` FOREIGN KEY (`episode_id`) REFERENCES `anime_episodes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `player_subtitles`;
CREATE TABLE `player_subtitles` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `episode_id` int NOT NULL,
  `subtitles_list` json DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `episode_id` (`episode_id`),
  CONSTRAINT `player_subtitles_episode_id_foreign` FOREIGN KEY (`episode_id`) REFERENCES `anime_episodes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `revoked_sessions`;
CREATE TABLE `revoked_sessions` (
  `token_hash` varchar(64) NOT NULL,
  `user_id` int unsigned NOT NULL,
  `revoked_at` datetime NOT NULL,
  `expires_at` datetime NOT NULL,
  PRIMARY KEY (`token_hash`),
  KEY `idx_revoked_sessions_expires` (`expires_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

DROP TABLE IF EXISTS `settings`;
CREATE TABLE `settings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `class` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `value` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `type` varchar(31) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'string',
  `context` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `settings_class_key_unique` (`class`,`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `user_ad_free_purchases`;
CREATE TABLE `user_ad_free_purchases` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `days` int unsigned NOT NULL,
  `cost_xec` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `starts_at` datetime NOT NULL,
  `ends_at` datetime NOT NULL,
  `balance_before` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `balance_after` decimal(14,4) NOT NULL DEFAULT '0.0000',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `user_ads`;
CREATE TABLE `user_ads` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `slot` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `title` varchar(160) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'image',
  `provider` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `provider_client_id` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `provider_slot_id` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `provider_format` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `provider_responsive` tinyint unsigned DEFAULT '1',
  `image_url` varchar(600) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `mobile_image_url` varchar(600) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `target_url` varchar(600) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `iframe_url` varchar(800) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `script_url` varchar(800) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `script_code` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `html` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `is_active` tinyint unsigned NOT NULL DEFAULT '1',
  `sort_order` int NOT NULL DEFAULT '0',
  `duration_seconds` int unsigned DEFAULT NULL,
  `starts_at` datetime DEFAULT NULL,
  `ends_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `slot` (`slot`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `user_conversation_members`;
CREATE TABLE `user_conversation_members` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `conversation_id` int unsigned NOT NULL,
  `user_id` int unsigned NOT NULL,
  `last_read_message_id` int unsigned NOT NULL DEFAULT '0',
  `last_read_at` datetime DEFAULT NULL,
  `muted` tinyint(1) NOT NULL DEFAULT '0',
  `archived_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_conversation_members_unique` (`conversation_id`,`user_id`),
  KEY `idx_user_conversation_members_user` (`user_id`,`deleted_at`),
  KEY `idx_user_conversation_members_conversation` (`conversation_id`,`deleted_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `user_conversations`;
CREATE TABLE `user_conversations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `type` enum('direct') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'direct',
  `subject` varchar(180) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_message_id` int unsigned DEFAULT NULL,
  `last_message_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_user_conversations_last` (`last_message_at`,`deleted_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `user_episode_purchases`;
CREATE TABLE `user_episode_purchases` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `anime_id` int unsigned NOT NULL DEFAULT '0',
  `episode_id` int unsigned NOT NULL DEFAULT '0',
  `episode_number` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `cost_xec` decimal(12,2) NOT NULL DEFAULT '0.00',
  `balance_before` decimal(12,2) NOT NULL DEFAULT '0.00',
  `balance_after` decimal(12,2) NOT NULL DEFAULT '0.00',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_episode_premium_user_episode_unique` (`user_id`,`episode_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `user_episode_submissions`;
CREATE TABLE `user_episode_submissions` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `anime_id` int unsigned NOT NULL,
  `episode_id` int unsigned DEFAULT NULL,
  `anime_title` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `episode_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `episode_title` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `episode_title_romanji` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `request_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'type_check',
  `raw` tinyint(1) NOT NULL DEFAULT '0',
  `sub` tinyint(1) NOT NULL DEFAULT '0',
  `dub` tinyint(1) NOT NULL DEFAULT '0',
  `premium` tinyint(1) DEFAULT '0',
  `xec` int DEFAULT '0',
  `filler` tinyint(1) DEFAULT '0',
  `recap` tinyint(1) DEFAULT '0',
  `embed_type` tinyint(1) DEFAULT NULL,
  `embed_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `embed_order` int DEFAULT NULL,
  `embed_frame` varchar(650) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `group_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `group_translator` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'pending',
  `note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `review_reason` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `review_note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `reviewed_by` int unsigned DEFAULT NULL,
  `reviewed_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `status_created_at` (`status`,`created_at`),
  KEY `episode_id_status` (`episode_id`,`status`),
  KEY `user_id_episode_id` (`user_id`,`episode_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `user_friendships`;
CREATE TABLE `user_friendships` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `requester_id` int unsigned NOT NULL,
  `addressee_id` int unsigned NOT NULL,
  `user_low_id` int unsigned NOT NULL,
  `user_high_id` int unsigned NOT NULL,
  `status` enum('pending','accepted','declined','blocked') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `requested_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `responded_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_friendships_pair_unique` (`user_low_id`,`user_high_id`),
  KEY `idx_user_friendships_requester` (`requester_id`,`status`,`deleted_at`),
  KEY `idx_user_friendships_addressee` (`addressee_id`,`status`,`deleted_at`),
  KEY `idx_user_friendships_pair_status` (`user_low_id`,`user_high_id`,`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `user_groups`;
CREATE TABLE `user_groups` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_user_groups_user_id` (`user_id`),
  KEY `idx_user_groups_group` (`group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `user_messages`;
CREATE TABLE `user_messages` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `conversation_id` int unsigned NOT NULL,
  `sender_id` int unsigned NOT NULL,
  `body` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_user_messages_conversation` (`conversation_id`,`id`,`deleted_at`),
  KEY `idx_user_messages_sender` (`sender_id`,`deleted_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `user_notifications`;
CREATE TABLE `user_notifications` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `type` enum('episode','comment','system') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT '0',
  `notify` json NOT NULL,
  `episode_id` int unsigned DEFAULT NULL,
  `comment_id` int unsigned DEFAULT NULL,
  `read_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `type` (`type`),
  KEY `is_read` (`is_read`),
  KEY `created_at` (`created_at`),
  KEY `episode_id` (`episode_id`),
  KEY `comment_id` (`comment_id`),
  KEY `idx_user_notifications_user_list` (`user_id`,`deleted_at`,`id`),
  KEY `idx_user_notifications_user_unread` (`user_id`,`deleted_at`,`is_read`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `user_point_history`;
CREATE TABLE `user_point_history` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `point` int NOT NULL,
  `action` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `reference_id` int unsigned DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `balance_before` int NOT NULL DEFAULT '0',
  `balance_after` int NOT NULL DEFAULT '0',
  `event` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'system',
  `reference_type` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `user_point_history_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `user_points`;
CREATE TABLE `user_points` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `total_point` int NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user_point_user_id_unique` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `user_reports`;
CREATE TABLE `user_reports` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `entity_type` enum('episode','comment','anime_comment','user','topic') COLLATE utf8mb4_general_ci NOT NULL,
  `entity_id` int NOT NULL,
  `report_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `user_watch_progress`;
CREATE TABLE `user_watch_progress` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `anime_id` int NOT NULL,
  `episode_id` int unsigned NOT NULL,
  `episode_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `method_type` enum('player','interval') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'interval',
  `time` int DEFAULT NULL,
  `percent` int DEFAULT NULL,
  `duration` int DEFAULT NULL,
  `source_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `source_type_label` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `source_fansub` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `source_embed_id` int unsigned DEFAULT NULL,
  `source_embed_order` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `source_embed_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `source_updated_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_user_watch_progress_lookup` (`user_id`,`anime_id`,`episode_id`,`deleted_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `user_watchlist`;
CREATE TABLE `user_watchlist` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `anime_id` int NOT NULL,
  `type` int NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_watchlist_user_anime_unique` (`user_id`,`anime_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `user_xec_ledger`;
CREATE TABLE `user_xec_ledger` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `transaction_type` enum('deposit','withdrawal','credit','debit','income','expense') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `balance_before` decimal(10,2) NOT NULL,
  `balance_after` decimal(10,2) NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `event` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `reference_type` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `reference_id` int unsigned DEFAULT NULL,
  `actor_id` int unsigned DEFAULT NULL,
  `metadata` json DEFAULT NULL,
  `idempotency_key` varchar(160) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_user_xec_idempotency` (`idempotency_key`),
  KEY `user_id` (`user_id`),
  KEY `idx_user_xec_ledger_reference` (`reference_type`,`reference_id`),
  KEY `idx_user_xec_ledger_event` (`event`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email` varchar(254) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `password_hash` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `avatar` tinyint DEFAULT '1',
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status_message` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `mod_panel_blocked` tinyint(1) NOT NULL DEFAULT '0',
  `xec_balance` decimal(10,2) NOT NULL DEFAULT '0.00',
  `preferences` json DEFAULT NULL,
  `privacy` json DEFAULT NULL,
  `profile_appearance` json DEFAULT NULL,
  `notification_settings` json DEFAULT NULL,
  `last_active` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `idx_users_email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Default seed data
-- Default site settings
INSERT INTO `settings` (`class`, `key`, `value`, `type`, `context`, `created_at`, `updated_at`) VALUES
('Config\\Anitium', 'SiteName', 'Anitium', 'string', 'Frontend site name.', NOW(), NOW()),
('Config\\Anitium', 'SiteTagline', 'Anime and Manga Translation World', 'string', 'Short public tagline.', NOW(), NOW()),
('Config\\Anitium', 'SiteDescription', 'Discover and watch your favorite anime series.', 'string', 'Public SEO and frontend description.', NOW(), NOW()),
('Config\\Anitium', 'SiteLogo', 'assets/anime/images/logo.png', 'string', 'Public logo path or URL.', NOW(), NOW()),
('Config\\Anitium', 'SiteFavicon', '/favicon-32x32.png', 'string', 'Browser favicon path or URL.', NOW(), NOW()),
('Config\\Anitium', 'PublicMediaStorageEnabled', '0', 'boolean', 'Enable external upload storage for poster and slider images.', NOW(), NOW()),
('Config\\Anitium', 'PublicMediaStorageBaseUrl', '', 'string', 'Public base URL used for uploaded poster and slider images.', NOW(), NOW()),
('Config\\Anitium', 'PublicMediaStorageFtpHost', '', 'string', 'FTP host used when provider is ftp.', NOW(), NOW()),
('Config\\Anitium', 'PublicMediaStorageFtpPort', '21', 'integer', 'FTP port used when provider is ftp.', NOW(), NOW()),
('Config\\Anitium', 'PublicMediaStorageFtpUser', '', 'string', 'FTP username used when provider is ftp.', NOW(), NOW()),
('Config\\Anitium', 'PublicMediaStorageFtpPassword', '', 'string', 'FTP password used when provider is ftp.', NOW(), NOW()),
('Config\\Anitium', 'PublicMediaStorageFtpSecure', '0', 'boolean', 'Use explicit FTPS when provider is ftp.', NOW(), NOW()),
('Config\\Anitium', 'PublicMediaStorageFtpRemotePath', '/public_html/anime-media', 'string', 'FTP remote directory where poster and slider folders are created.', NOW(), NOW()),
('Config\\Anitium', 'SocialDiscord', 'https://discord.gg/Anitium', 'string', 'Discord community URL.', NOW(), NOW()),
('Config\\Anitium', 'SocialTelegram', '', 'string', 'Telegram community URL.', NOW(), NOW()),
('Config\\Anitium', 'CommentSystemEnabled', '1', 'boolean', 'Enable comments, replies, votes, and reports.', NOW(), NOW()),
('Config\\Anitium', 'CommunitySystemEnabled', '1', 'boolean', 'Enable community topics and discussion pages.', NOW(), NOW()),
('Config\\Anitium', 'SocialSystemEnabled', '1', 'boolean', 'Enable friend requests and friends lists.', NOW(), NOW()),
('Config\\Anitium', 'MessagesSystemEnabled', '1', 'boolean', 'Enable private messages and inbox features.', NOW(), NOW()),
('Config\\Anitium', 'MembershipRequired', '0', 'boolean', 'Require users to sign in or register before accessing frontend pages.', NOW(), NOW()),
('Config\\Anitium', 'AutoEmbedApiEnabled', '1', 'boolean', 'Expose enabled automatic embed providers.', NOW(), NOW()),
('Config\\Anitium', 'FrontendUrlEncodingEnabled', '0', 'boolean', 'Use encoded anime route IDs on frontend detail and watch URLs.', NOW(), NOW()),
('Config\\Anitium', 'FrontendUrlEncodingSalt', 'anitium-url-v1', 'string', 'Salt used to generate reversible frontend anime URL codes.', NOW(), NOW()),
('Config\\Anitium', 'FrontendUrlLegacyNumericEnabled', '1', 'boolean', 'Allow legacy numeric anime route IDs to keep old links working.', NOW(), NOW()),
('Config\\Anitium', 'AnimeApiJikanBaseUrl', 'https://api.jikan.moe/v4', 'string', 'Jikan REST API base URL.', NOW(), NOW()),
('Config\\Anitium', 'AnimeApiAnilistGraphqlUrl', 'https://graphql.anilist.co', 'string', 'AniList GraphQL API URL.', NOW(), NOW()),
('Config\\Anitium', 'AnimeApiDefaultProvider', 'jikan', 'string', 'Admin anime API provider: jikan or anilist.', NOW(), NOW()),
('Config\\Anitium', 'XecSystem', '1', 'boolean', 'Enable XEC account economy.', NOW(), NOW()),
('Config\\Anitium', 'AdsSystemEnabled', '1', 'boolean', 'Enable frontend ad rendering.', NOW(), NOW()),
('Config\\Anitium', 'AdsAdblockDetectionEnabled', '1', 'boolean', 'Enable adblock detection warning.', NOW(), NOW()),
('Config\\Anitium', 'AdsPlayerDelaySeconds', '5', 'integer', 'Player pre-roll duration in seconds.', NOW(), NOW()),
('Config\\Anitium', 'AdsDisablePlans', '1:10,10:80,30:200', 'string', 'Ad-free plan rows saved as day:XEC pairs.', NOW(), NOW()),
('Config\\Anitium', 'GroupLevelMaxPoint', '32000', 'integer', 'Maximum point value for rank level distribution.', NOW(), NOW()),
('Config\\Anitium', 'PointAnimeRating', '2', 'integer', 'Points for rating an anime.', NOW(), NOW()),
('Config\\Anitium', 'PointAnimeWatchlist', '1', 'integer', 'Points for adding anime to watchlist.', NOW(), NOW()),
('Config\\Anitium', 'PointEpisodeComment', '3', 'integer', 'Points for posting an episode comment.', NOW(), NOW()),
('Config\\Anitium', 'XecEpisodeComment', '1', 'integer', 'XEC reward for posting an episode comment.', NOW(), NOW()),
('Config\\Anitium', 'PointEpisodeCommentReply', '2', 'integer', 'Points for replying to an episode comment.', NOW(), NOW()),
('Config\\Anitium', 'PointEpisodeCommentVote', '1', 'integer', 'Points for voting on an episode comment.', NOW(), NOW()),
('Config\\Anitium', 'PointCommunityTopic', '5', 'integer', 'Points for creating a community topic.', NOW(), NOW()),
('Config\\Anitium', 'XecCommunityTopic', '1', 'integer', 'XEC reward for creating a community topic.', NOW(), NOW()),
('Config\\Anitium', 'PointCommunityTopicVote', '1', 'integer', 'Points for voting on a community topic.', NOW(), NOW()),
('Config\\Anitium', 'PointCommunityComment', '3', 'integer', 'Points for posting a community comment.', NOW(), NOW()),
('Config\\Anitium', 'PointCommunityCommentReply', '2', 'integer', 'Points for replying to a community comment.', NOW(), NOW()),
('Config\\Anitium', 'PointCommunityCommentVote', '1', 'integer', 'Points for voting on a community comment.', NOW(), NOW()),
('Config\\Anitium', 'UserCheckEpisodeTypeApproveXec', '3', 'integer', 'XEC reward for approved episode type checks.', NOW(), NOW()),
('Config\\Anitium', 'UserCheckEpisodeTypeApprovePoint', '8', 'integer', 'Point reward for approved episode type checks.', NOW(), NOW()),
('Config\\Anitium', 'UserCheckEpisodeTypeRejectXec', '1', 'integer', 'XEC reward for rejected episode type checks.', NOW(), NOW()),
('Config\\Anitium', 'UserCheckEpisodeTypeRejectPoint', '3', 'integer', 'Point reward for rejected episode type checks.', NOW(), NOW()),
('Config\\Anitium', 'UserCheckEmbedAddApproveXec', '6', 'integer', 'XEC reward for approved embed submissions.', NOW(), NOW()),
('Config\\Anitium', 'UserCheckEmbedAddApprovePoint', '14', 'integer', 'Point reward for approved embed submissions.', NOW(), NOW()),
('Config\\Anitium', 'UserCheckEmbedAddRejectXec', '2', 'integer', 'XEC reward for rejected embed submissions.', NOW(), NOW()),
('Config\\Anitium', 'UserCheckEmbedAddRejectPoint', '5', 'integer', 'Point reward for rejected embed submissions.', NOW(), NOW()),
('Config\\Anitium', 'UserCheckAutoApiMissingApproveXec', '3', 'integer', 'XEC reward for approved missing AutoApi reports.', NOW(), NOW()),
('Config\\Anitium', 'UserCheckAutoApiMissingApprovePoint', '8', 'integer', 'Point reward for approved missing AutoApi reports.', NOW(), NOW()),
('Config\\Anitium', 'UserCheckAutoApiMissingRejectXec', '1', 'integer', 'XEC reward for rejected missing AutoApi reports.', NOW(), NOW()),
('Config\\Anitium', 'UserCheckAutoApiMissingRejectPoint', '3', 'integer', 'Point reward for rejected missing AutoApi reports.', NOW(), NOW()),
('Config\\Anitium', 'UserCheckEpisodeAddApproveXec', '8', 'integer', 'XEC reward for approved episode additions.', NOW(), NOW()),
('Config\\Anitium', 'UserCheckEpisodeAddApprovePoint', '18', 'integer', 'Point reward for approved episode additions.', NOW(), NOW()),
('Config\\Anitium', 'UserCheckEpisodeAddRejectXec', '2', 'integer', 'XEC reward for rejected episode additions.', NOW(), NOW()),
('Config\\Anitium', 'UserCheckEpisodeAddRejectPoint', '6', 'integer', 'Point reward for rejected episode additions.', NOW(), NOW()),
('Config\\Anitium', 'UserCheckEpisodeEditApproveXec', '4', 'integer', 'XEC reward for approved episode edits.', NOW(), NOW()),
('Config\\Anitium', 'UserCheckEpisodeEditApprovePoint', '10', 'integer', 'Point reward for approved episode edits.', NOW(), NOW()),
('Config\\Anitium', 'UserCheckEpisodeEditRejectXec', '1', 'integer', 'XEC reward for rejected episode edits.', NOW(), NOW()),
('Config\\Anitium', 'UserCheckEpisodeEditRejectPoint', '4', 'integer', 'Point reward for rejected episode edits.', NOW(), NOW()),
('Config\\Anitium', 'UserCheckEpisodeDeleteApproveXec', '4', 'integer', 'XEC reward for approved episode delete requests.', NOW(), NOW()),
('Config\\Anitium', 'UserCheckEpisodeDeleteApprovePoint', '10', 'integer', 'Point reward for approved episode delete requests.', NOW(), NOW()),
('Config\\Anitium', 'UserCheckEpisodeDeleteRejectXec', '1', 'integer', 'XEC reward for rejected episode delete requests.', NOW(), NOW()),
('Config\\Anitium', 'UserCheckEpisodeDeleteRejectPoint', '4', 'integer', 'Point reward for rejected episode delete requests.', NOW(), NOW()),
('Config\\Anitium', 'JobsWorkerSecret', 'local-jobs-worker-secret', 'string', 'Secret token for URL cron or external worker calls.', NOW(), NOW()),
('Config\\Anitium', 'JobsBatchSize', '500', 'integer', 'Maximum users processed inside one notification delivery job batch.', NOW(), NOW()),
('Config\\Anitium', 'JobsWorkerLimit', '5', 'integer', 'Default number of due queue jobs processed per worker tick.', NOW(), NOW()),
('Config\\Anitium', 'UserDataCleanupEnabled', '1', 'boolean', 'Automatically delete old notifications and private messages during worker ticks.', NOW(), NOW()),
('Config\\Anitium', 'NotificationReadRetentionDays', '90', 'integer', 'Days to keep read user notifications before hard deletion.', NOW(), NOW()),
('Config\\Anitium', 'NotificationUnreadRetentionDays', '180', 'integer', 'Days to keep unread user notifications before hard deletion.', NOW(), NOW()),
('Config\\Anitium', 'MessageRetentionDays', '365', 'integer', 'Days to keep private messages before hard deletion.', NOW(), NOW()),
('Config\\Anitium', 'UserDataCleanupLimit', '1000', 'integer', 'Maximum old notification/message rows deleted per cleanup pass.', NOW(), NOW()),
('Config\\Anitium', 'UserDataCleanupIntervalMinutes', '60', 'integer', 'Minimum minutes between automatic user data cleanup passes.', NOW(), NOW()),
('Config\\Anitium', 'RealtimeNotificationsEnabled', '1', 'boolean', 'Enable one-way SSE notifications backed by Redis pub/sub.', NOW(), NOW()),
('Config\\Anitium', 'RealtimeNotificationsMode', 'anitium', 'string', 'Realtime notification transport mode: normal, redis, upstash, or anitium.', NOW(), NOW()),
('Config\\Anitium', 'RealtimeNotificationsRedisUrl', '', 'string', 'Server Redis URL for realtime notification pub/sub.', NOW(), NOW()),
('Config\\Anitium', 'RealtimeNotificationsNamespace', 'anitium', 'string', 'Site-specific Redis pub/sub namespace for shared Redis URLs.', NOW(), NOW()),
('Config\\Anitium', 'RealtimeNotificationsUpstashRedisUrl', 'rediss://default:gQAAAAAAAWgPAAIgcDI3NDcxYjhmNzUwNjI0NDFlYjZmNDllZTE4YmQ0OTA4NQ@tolerant-marten-92175.upstash.io:6379', 'string', 'Upstash Redis compatible rediss:// URL.', NOW(), NOW())
ON DUPLICATE KEY UPDATE value = VALUES(value), type = VALUES(type), context = VALUES(context), updated_at = NOW();

INSERT INTO `community_categories` (`name`, `slug`, `description`, `icon`, `tone`, `staff_only`, `sort_order`, `is_active`, `created_at`, `updated_at`) VALUES
('Announcements', 'announcements', 'Site news and official updates.', 'megaphone', 'sky', 1, 10, 1, NOW(), NOW()),
('General', 'general', 'General anime and community discussion.', 'message-circle', 'emerald', 0, 20, 1, NOW(), NOW()),
('Anime Talk', 'anime-talk', 'Talk about episodes, seasons and recommendations.', 'sparkles', 'violet', 0, 30, 1, NOW(), NOW()),
('Support', 'support', 'Ask for help and report site usage problems.', 'help-circle', 'amber', 0, 40, 1, NOW(), NOW()),
('Staff', 'staff', 'Staff-only coordination area.', 'shield', 'rose', 1, 90, 1, NOW(), NOW())
ON DUPLICATE KEY UPDATE name = VALUES(name), description = VALUES(description), icon = VALUES(icon), tone = VALUES(tone), staff_only = VALUES(staff_only), sort_order = VALUES(sort_order), is_active = VALUES(is_active), updated_at = NOW();

INSERT INTO `anime_genre_catalog` (`genre`) VALUES
('Action'),
('Adventure'),
('Avant Garde'),
('Award Winning'),
('Boys Love'),
('Comedy'),
('Drama'),
('Fantasy'),
('Girls Love'),
('Gourmet'),
('Horror'),
('Mystery'),
('Romance'),
('Sci-Fi'),
('Slice of Life'),
('Sports'),
('Supernatural'),
('Suspense'),
('Ecchi'),
('Erotica'),
('Hentai'),
('Adult Cast'),
('Anthropomorphic'),
('CGDCT'),
('Childcare'),
('Combat Sports'),
('Crossdressing'),
('Delinquents'),
('Detective'),
('Educational'),
('Gag Humor'),
('Gore'),
('Harem'),
('High Stakes Game'),
('Historical'),
('Idols (Female)'),
('Idols (Male)'),
('Isekai'),
('Iyashikei'),
('Love Polygon'),
('Magical Sex Shift'),
('Mahou Shoujo'),
('Martial Arts'),
('Mecha'),
('Medical'),
('Military'),
('Music'),
('Mythology'),
('Organized Crime'),
('Otaku Culture'),
('Parody'),
('Performing Arts'),
('Pets'),
('Psychological'),
('Racing'),
('Reincarnation'),
('Reverse Harem'),
('Romantic Subtext'),
('Samurai'),
('School'),
('Showbiz'),
('Space'),
('Strategy Game'),
('Super Power'),
('Survival'),
('Team Sports'),
('Time Travel'),
('Vampire'),
('Video Game'),
('Visual Arts'),
('Workplace')
ON DUPLICATE KEY UPDATE genre = VALUES(genre);

SET FOREIGN_KEY_CHECKS=1;
