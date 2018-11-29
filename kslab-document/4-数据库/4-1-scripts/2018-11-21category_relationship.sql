/*
 Navicat MySQL Data Transfer

 Source Server         : kslab-write
 Source Server Type    : MySQL
 Source Server Version : 80013
 Source Host           : 172.16.0.129:3307
 Source Schema         : kslab-test

 Target Server Type    : MySQL
 Target Server Version : 80013
 File Encoding         : 65001

 Date: 21/11/2018 17:11:27
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for category_relationship
-- ----------------------------
DROP TABLE IF EXISTS `category_relationship`;
CREATE TABLE `category_relationship`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `category_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '产品类别id',
  `relation_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '品牌系列对应表id',
  `status` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '状态：1正常 0删除',
  `created_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '产品品牌系列对应表' ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
