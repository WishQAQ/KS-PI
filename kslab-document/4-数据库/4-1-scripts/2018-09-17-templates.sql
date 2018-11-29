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

 Date: 09/17/2018 13:59:13 PM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `templates`
-- ----------------------------
DROP TABLE IF EXISTS `templates`;
CREATE TABLE `templates` (
  `id` int(11) NOT NULL,
  `template_id` varchar(255) DEFAULT NULL COMMENT '模版全局唯一id',
  `type` tinyint(1) DEFAULT NULL COMMENT '模版类型：1短信 2邮件 3消息',
  `content` varchar(255) DEFAULT NULL COMMENT '模版内容',
  `created_id` varchar(255) DEFAULT NULL,
  `updated_id` varchar(255) DEFAULT NULL,
  `cteated_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL COMMENT '状态：1正常 0删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='模版表';

SET FOREIGN_KEY_CHECKS = 1;
