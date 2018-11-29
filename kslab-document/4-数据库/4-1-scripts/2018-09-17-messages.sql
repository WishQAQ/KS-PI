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

 Date: 09/17/2018 13:58:55 PM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `messages`
-- ----------------------------
DROP TABLE IF EXISTS `messages`;
CREATE TABLE `messages` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `message_id` varchar(255) DEFAULT NULL COMMENT '消息全局唯一id',
  `template_id` varchar(255) DEFAULT NULL COMMENT '模版id',
  `type` tinyint(1) DEFAULT NULL COMMENT '消息类型：1短信 2邮件 3消息',
  `content` varchar(255) DEFAULT NULL COMMENT '消息内容',
  `created_id` varchar(255) DEFAULT NULL,
  `receiver_id` varchar(255) DEFAULT NULL COMMENT '接收人uid',
  `updated_id` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL COMMENT '状态：1正常 0删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='消息表';

SET FOREIGN_KEY_CHECKS = 1;
