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

 Date: 16/10/2018 14:49:03
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for menu_major
-- ----------------------------
DROP TABLE IF EXISTS `menu_major`;
CREATE TABLE `menu_major`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `menu_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '全局唯一菜单ID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '菜单列表名称',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '菜单解释',
  `type` int(11) NULL DEFAULT NULL COMMENT '菜单级别：1=》一级菜单，2=》二级菜单.....',
  `pid` int(11) NULL DEFAULT NULL COMMENT '父id',
  `status` int(11) NULL DEFAULT NULL,
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '专业目录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for menu_relationship
-- ----------------------------
DROP TABLE IF EXISTS `menu_relationship`;
CREATE TABLE `menu_relationship`  (
  `menu_shop` int(11) NULL DEFAULT NULL COMMENT '商城菜单ID',
  `menu_ui` int(11) NULL DEFAULT NULL COMMENT '弹窗目录|上传菜单目录ID',
  `menu_major` int(11) NULL DEFAULT NULL COMMENT '专业目录ID',
  `global_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '全局对应ID',
  `table_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '对应数据库表'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '目录对应关系表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for menu_shop
-- ----------------------------
DROP TABLE IF EXISTS `menu_shop`;
CREATE TABLE `menu_shop`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `menu_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '全局唯一菜单ID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '菜单列表名称',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '跳转连接',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '图标',
  `type` int(11) NULL DEFAULT NULL COMMENT '菜单级别：1=》一级菜单，2=》二级菜单.....',
  `pid` int(11) NULL DEFAULT NULL COMMENT '父id',
  `status` int(11) NULL DEFAULT NULL COMMENT '状态：0=》正常，1=》异常',
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for menu_ui
-- ----------------------------
DROP TABLE IF EXISTS `menu_ui`;
CREATE TABLE `menu_ui`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `menu_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '全局唯一菜单ID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '菜单列表名称',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '菜单解释',
  `type` int(11) NULL DEFAULT NULL COMMENT '菜单级别：1=》一级菜单，2=》二级菜单.....',
  `pid` int(11) NULL DEFAULT NULL COMMENT '父id',
  `status` int(11) NULL DEFAULT NULL COMMENT '状态：0=》上传菜单目录，1=》异常',
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '弹窗目录| 上传菜单目录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for web_agreement
-- ----------------------------
DROP TABLE IF EXISTS `web_agreement`;
CREATE TABLE `web_agreement`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `agreement_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '协议全局ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '上传协议标题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '上传协议内容',
  `attachment` json NULL COMMENT '附件地址',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '上传协议类型-中文',
  `status` tinyint(255) NULL DEFAULT NULL COMMENT '状态值: 0=>禁用 1 => 正常',
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '上传协议' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for web_background
-- ----------------------------
DROP TABLE IF EXISTS `web_background`;
CREATE TABLE `web_background`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '图片名称',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '图片路由地址',
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '页面背景表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for web_icon
-- ----------------------------
DROP TABLE IF EXISTS `web_icon`;
CREATE TABLE `web_icon`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `icon_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'ICON全局ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'ICON名称',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'ICON路由地址',
  `status` tinyint(1) NULL DEFAULT NULL COMMENT '状态值:0=>禁用 1=>正常 2=>置顶',
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'icon表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for web_review
-- ----------------------------
DROP TABLE IF EXISTS `web_review`;
CREATE TABLE `web_review`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `review_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '审核信息全局ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '审核名称',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '审核描述',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '审核类型-中文',
  `type_id` tinyint(3) NULL DEFAULT NULL COMMENT '类型ID',
  `status` tinyint(1) NULL DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '审核信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for web_video_title
-- ----------------------------
DROP TABLE IF EXISTS `web_video_title`;
CREATE TABLE `web_video_title`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '视频小标题名称',
  `en_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '视频小标题英文名称',
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '视频小标题图标',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '类型',
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `updated_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '网页视频小标题' ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
