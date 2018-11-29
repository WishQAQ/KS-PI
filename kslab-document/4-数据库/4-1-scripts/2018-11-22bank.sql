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

 Date: 22/11/2018 11:03:51
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for bank
-- ----------------------------
DROP TABLE IF EXISTS `bank`;
CREATE TABLE `bank`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `bank_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '银行编号id',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '银行名称',
  `status` tinyint(1) NULL DEFAULT NULL COMMENT '状态：1正常 0删除',
  `created_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '银行图片url',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '银行编号表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bank
-- ----------------------------
INSERT INTO `bank` VALUES (1, 1002, '工商银行', 1, NULL, NULL, NULL, NULL);
INSERT INTO `bank` VALUES (2, 1005, '农业银行', 1, NULL, NULL, NULL, NULL);
INSERT INTO `bank` VALUES (3, 1026, '中国银行', 1, NULL, NULL, NULL, NULL);
INSERT INTO `bank` VALUES (4, 1003, '建设银行\r\n\r\n建设银行', 1, NULL, NULL, NULL, NULL);
INSERT INTO `bank` VALUES (5, 1001, '招商银行', 1, NULL, NULL, NULL, NULL);
INSERT INTO `bank` VALUES (6, 1066, '邮储银行', 1, NULL, NULL, NULL, NULL);
INSERT INTO `bank` VALUES (7, 1020, '交通银行', 1, NULL, NULL, NULL, NULL);
INSERT INTO `bank` VALUES (8, 1004, '浦发银行', 1, NULL, NULL, NULL, NULL);
INSERT INTO `bank` VALUES (9, 1006, '民生银行', 1, NULL, NULL, NULL, NULL);
INSERT INTO `bank` VALUES (10, 1009, '兴业银行', 1, NULL, NULL, NULL, NULL);
INSERT INTO `bank` VALUES (11, 1010, '平安银行', 1, NULL, NULL, NULL, NULL);
INSERT INTO `bank` VALUES (12, 1021, '中信银行', 1, NULL, NULL, NULL, NULL);
INSERT INTO `bank` VALUES (13, 1025, '华夏银行', 1, NULL, NULL, NULL, NULL);
INSERT INTO `bank` VALUES (14, 1027, '广发银行', 1, NULL, NULL, NULL, NULL);
INSERT INTO `bank` VALUES (15, 1022, '光大银行', 1, NULL, NULL, NULL, NULL);
INSERT INTO `bank` VALUES (16, 1032, '北京银行', 1, NULL, NULL, NULL, NULL);
INSERT INTO `bank` VALUES (17, 1056, '宁波银行', 1, NULL, NULL, NULL, NULL);

SET FOREIGN_KEY_CHECKS = 1;
