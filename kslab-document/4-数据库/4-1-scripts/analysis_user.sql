/*
 Navicat Premium Data Transfer

 Source Server         : 酷耍
 Source Server Type    : MySQL
 Source Server Version : 50724
 Source Host           : 172.16.0.129:3306
 Source Schema         : kslab-test

 Target Server Type    : MySQL
 Target Server Version : 50724
 File Encoding         : 65001

 Date: 31/10/2018 14:33:00
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for analysis_user
-- ----------------------------
DROP TABLE IF EXISTS `analysis_user`;
CREATE TABLE `analysis_user`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `follow` int(11) NULL DEFAULT NULL COMMENT '关注别人次数',
  `focus` int(11) NULL DEFAULT NULL COMMENT '被别人关注次数',
  `question` int(11) NULL DEFAULT NULL COMMENT '问别人',
  `answers` int(11) NULL DEFAULT NULL COMMENT '回答次数',
  `article_total` int(11) NULL DEFAULT NULL COMMENT '文章总数',
  `article_view` int(11) NULL DEFAULT NULL COMMENT '文章浏览数',
  `article_link` int(11) NULL DEFAULT NULL COMMENT '文章转发数',
  `article_like` int(11) NULL DEFAULT NULL COMMENT '文章点赞数',
  `article_comment` int(11) NULL DEFAULT NULL COMMENT '文章评论数',
  `video_total` int(11) NULL DEFAULT NULL COMMENT '视频总数',
  `video_view` int(11) NULL DEFAULT NULL COMMENT '视频浏览数',
  `video_link` int(11) NULL DEFAULT NULL COMMENT '视频转发数',
  `video_like` int(11) NULL DEFAULT NULL COMMENT '视频点赞数',
  `video_comment` int(11) NULL DEFAULT NULL COMMENT '视频评论数',
  `encyc_total` int(11) NULL DEFAULT NULL COMMENT '百科总数',
  `encyc_view` int(11) NULL DEFAULT NULL COMMENT '百科浏览数',
  `encyc_link` int(11) NULL DEFAULT NULL COMMENT '百科转发数',
  `encyc_like` int(11) NULL DEFAULT NULL COMMENT '百科点赞数',
  `income_total` int(11) NULL DEFAULT NULL COMMENT '总收入',
  `score_total` decimal(11, 1) NULL DEFAULT NULL COMMENT '总评分',
  `score_num` int(11) NULL DEFAULT NULL COMMENT '评论人数',
  `created_at` timestamp(0) NULL DEFAULT NULL COMMENT '记录时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
