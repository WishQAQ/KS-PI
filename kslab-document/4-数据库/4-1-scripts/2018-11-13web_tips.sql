/*
 Navicat Premium Data Transfer

 Source Server         : 酷耍
 Source Server Type    : MySQL
 Source Server Version : 80013
 Source Host           : 172.16.0.129:3307
 Source Schema         : kslab-test

 Target Server Type    : MySQL
 Target Server Version : 80013
 File Encoding         : 65001

 Date: 13/11/2018 19:20:26
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for web_tips
-- ----------------------------
DROP TABLE IF EXISTS `web_tips`;
CREATE TABLE `web_tips`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `tips_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '页面提示全局ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '提示名称',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '提示内容',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '提示类型',
  `created_at` timestamp(0) NULL DEFAULT NULL COMMENT '创建时间',
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '网站提示' ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
