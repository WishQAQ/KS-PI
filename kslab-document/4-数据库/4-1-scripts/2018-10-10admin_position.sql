/*
 Navicat Premium Data Transfer

 Source Server         : 酷耍
 Source Server Type    : MySQL
 Source Server Version : 50723
 Source Host           : 172.16.0.129:3306
 Source Schema         : kslab-test

 Target Server Type    : MySQL
 Target Server Version : 50723
 File Encoding         : 65001

 Date: 10/10/2018 14:20:21
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin_position
-- ----------------------------
DROP TABLE IF EXISTS `admin_position`;
CREATE TABLE `admin_position`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `department_id` int(11) NOT NULL COMMENT '部门id',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '职位名称',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '职位描述',
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '职位表' ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
