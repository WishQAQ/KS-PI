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

 Date: 21/11/2018 17:12:26
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for product_series
-- ----------------------------
DROP TABLE IF EXISTS `product_series`;
CREATE TABLE `product_series`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `series_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '系列全局唯一id',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '系列名称',
  `status` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '状态：1正常 0删除',
  `created_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '产品系列表' ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
