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

 Date: 09/06/2018 11:36:03 AM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `banners`
-- ----------------------------
DROP TABLE IF EXISTS `banners`;
CREATE TABLE `banners` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `banner_id` varchar(255) DEFAULT NULL COMMENT 'banner全局唯一id',
  `banner_url` varchar(255) DEFAULT NULL COMMENT 'banner图片地址',
  `section` tinyint(2) unsigned DEFAULT NULL COMMENT 'banner所对应板块：1文章 ',
  `self_define_text_1` varchar(255) DEFAULT NULL COMMENT '自定义文本1',
  `self_define_text_2` varchar(255) DEFAULT NULL COMMENT '自定义文本2',
  `self_define_text_3` varchar(255) DEFAULT NULL COMMENT '自定义文本3',
  `created_id` varchar(255) DEFAULT NULL,
  `updated_id` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL COMMENT '状态：1正常 0删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

SET FOREIGN_KEY_CHECKS = 1;
