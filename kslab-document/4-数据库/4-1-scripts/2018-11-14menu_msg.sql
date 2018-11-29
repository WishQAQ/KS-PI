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

 Date: 14/11/2018 19:15:06
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for menu_msg
-- ----------------------------
DROP TABLE IF EXISTS `menu_msg`;
CREATE TABLE `menu_msg`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `menu_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '菜单全局ID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '菜单列表名称',
  `parent` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '父菜单名称-冗余',
  `pid` int(11) NULL DEFAULT NULL COMMENT '父id',
  `type` tinyint(1) NULL DEFAULT NULL COMMENT '类型：0=>消息提示；1=>弹窗',
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '弹窗目录-消息提示类型' ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
