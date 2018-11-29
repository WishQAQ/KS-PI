/*
 Navicat Premium Data Transfer

 Source Server         : 酷耍
 Source Server Type    : MySQL
 Source Server Version : 50724
 Source Host           : 172.16.0.129:3306
 Source Schema         : kslab-test

 Target Server Type    : MySQL
 Target Server Version : 50724
 File Encoding         : 65001

 Date: 31/10/2018 14:33:05
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for analysis_web
-- ----------------------------
DROP TABLE IF EXISTS `analysis_web`;
CREATE TABLE `analysis_web`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `folder_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '板块类型-中文',
  `user_type` tinyint(1) NULL DEFAULT 1 COMMENT '用户类型 1 普通 2 公司',
  `articles` int(11) NULL DEFAULT 0 COMMENT '文章数量',
  `articles_view` int(11) NULL DEFAULT 0 COMMENT '文章浏览量',
  `questions` int(11) NULL DEFAULT 0 COMMENT '问题数量',
  `questions_view` int(11) NULL DEFAULT 0 COMMENT '问题浏览量',
  `answers` int(11) NULL DEFAULT 0 COMMENT '回答数量',
  `videos` int(11) NULL DEFAULT 0 COMMENT '视频数量',
  `videos_view` int(11) NULL DEFAULT 0 COMMENT '视频浏览量',
  `encyc` int(11) NULL DEFAULT 0 COMMENT '百科数量',
  `encyc_view` int(11) NULL DEFAULT 0 COMMENT '百科浏览量',
  `actives` int(11) NULL DEFAULT 0 COMMENT '活动数量',
  `actives_support` int(11) NULL DEFAULT 0 COMMENT '活动报名人数',
  `services` int(11) NULL DEFAULT 0 COMMENT '服务数量',
  `services_view` int(11) NULL DEFAULT 0 COMMENT '服务关注数量',
  `created_at` timestamp(0) NULL DEFAULT NULL COMMENT '记录时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 33 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
