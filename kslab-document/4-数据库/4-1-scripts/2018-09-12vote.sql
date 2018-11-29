/*
Navicat MySQL Data Transfer

Source Server         : 172.16.0.129
Source Server Version : 50723
Source Host           : 172.16.0.129:3306
Source Database       : kslab-test

Target Server Type    : MYSQL
Target Server Version : 50723
File Encoding         : 65001

Date: 2018-09-12 17:03:11
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `votes`
-- ----------------------------
DROP TABLE IF EXISTS `votes`;
CREATE TABLE `votes` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `upvote_id` varchar(255) DEFAULT NULL COMMENT '点赞全局唯一id',
  `source_id` varchar(255) DEFAULT NULL COMMENT '来源全局唯一id（文章，视频，问题，活动，商品等）',
  `like` tinyint(1) DEFAULT NULL COMMENT '1喜欢0不喜欢',
  `created_id` varchar(255) DEFAULT NULL COMMENT '用户id',
  `updated_id` varchar(255) DEFAULT NULL COMMENT '编辑者id',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL COMMENT '状态：1正常 0删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COMMENT='点赞表';


