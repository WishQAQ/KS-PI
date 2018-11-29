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

 Date: 15/11/2018 10:42:56
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for sensitive_type
-- ----------------------------
DROP TABLE IF EXISTS `sensitive_type`;
CREATE TABLE `sensitive_type`  (
  `type_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '就是把sensitive_word表中的type 提出来',
  `type_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '类型名称',
  PRIMARY KEY (`type_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '敏感词类型表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sensitive_type
-- ----------------------------
INSERT INTO `sensitive_type` VALUES (1, '色情');
INSERT INTO `sensitive_type` VALUES (2, '反动');
INSERT INTO `sensitive_type` VALUES (3, '暴恐');
INSERT INTO `sensitive_type` VALUES (4, '民生');
INSERT INTO `sensitive_type` VALUES (5, '贪腐');
INSERT INTO `sensitive_type` VALUES (6, '其他');

SET FOREIGN_KEY_CHECKS = 1;
