/*
 Navicat MySQL Data Transfer

 Source Server         : 172.16.0.129
 Source Server Type    : MySQL
 Source Server Version : 50723
 Source Host           : 172.16.0.129
 Source Database       : kslab-test

 Target Server Type    : MySQL
 Target Server Version : 50723
 File Encoding         : utf-8

 Date: 08/31/2018 10:57:32 AM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `brands`
-- ----------------------------
DROP TABLE IF EXISTS `brands`;
CREATE TABLE `brands` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `brand_id` varchar(255) NOT NULL COMMENT '品牌全局唯一id',
  `brand_pid` varchar(255) NOT NULL COMMENT '品牌全局唯一父id',
  `name` varchar(255) NOT NULL COMMENT '品牌名称',
  `description` varchar(255) DEFAULT NULL COMMENT '品牌描述',
  `status` tinyint(1) DEFAULT NULL COMMENT '状态：1正常 0删除',
  `created_id` varchar(255) DEFAULT NULL,
  `updated_id` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='品牌表';

SET FOREIGN_KEY_CHECKS = 1;
